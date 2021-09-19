static const char *__doc__ = "XDP stats program\n"
	" - Finding xdp_stats_map via --dev name info\n";

#include <assert.h>
#include <libgen.h>
#include <perf-sys.h>
#include <poll.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/sysinfo.h>
#include <unistd.h>
#include <time.h>

#include "../common/common_params.h"
#include "common/policy_struct_kern_user.h"
#include "../common/common_user_bpf_xdp.h"

#include "bpf_util.h" /* bpf_num_possible_cpus */

static const struct option_wrapper long_options[] = {
	{{"help",        no_argument,		NULL, 'h' },
	 "Show help", false},

	{{"dev",         required_argument,	NULL, 'd' },
	 "Operate on device <ifname>", "<ifname>", true},

	{{"quiet",       no_argument,		NULL, 'q' },
	 "Quiet mode (no output)"},

	{{0, 0, NULL,  0 }}
};

#ifndef PATH_MAX
#define PATH_MAX	4096
#endif

#define MAX_CPU 128
#define NS_IN_SEC 1000000000
#define PAGE_CNT 8

#define INTERVAL 1
#define LOCK_TIME 5

#define BLOCK 1
#define UNBLOCK 0

const char *pin_basedir =  "/sys/fs/bpf";
struct bpf_map_info map_expect = { 0 };
struct bpf_map_info info = { 0 };
char pin_dir[PATH_MAX];

//==================================================
struct perf_event_sample {
	struct perf_event_header header;
	__u64 timestamp;
	__u32 size;
	struct pkt_meta meta;
	__u8 pkt_data[64];
};

static __u32 xdp_flags;

#define POLICIES_FILE "policy/policy"
struct policy
{
    int id;
    __u32 ip;
    int threshold;
};

struct policy list_policy[10];
int policy_len;

struct perf_event_sample packets_queue[3000000];
int packets_queue_len;

unsigned long time_start;
unsigned long time_end;
unsigned long prev_time;

struct policy_stats_ip
{
	//Hang 0 chua IP, hang 1 chua so lan gui goi tin
	__u32 ip[2][100];
	__u32 num_ip;
};

#define IP_DYNAMIC 100
__u32 count_down[2][IP_DYNAMIC];

//======================================================
void meta_print(struct pkt_meta meta, __u64 timestamp)
{
	char src_str[INET_ADDRSTRLEN];
	char dst_str[INET_ADDRSTRLEN];
	char l3_str[32];
	char l4_str[32];

	switch (meta.l3_proto) {
	case ETH_P_IP:
		strcpy(l3_str, "IP");
		inet_ntop(AF_INET, &meta.src, src_str, INET_ADDRSTRLEN);
		inet_ntop(AF_INET, &meta.dst, dst_str, INET_ADDRSTRLEN);
		break;
	default:
		sprintf(l3_str, "%04x", meta.l3_proto);
	}

	switch (meta.l4_proto) {
	case IPPROTO_TCP:
		sprintf(l4_str, "TCP seq %d", ntohl(meta.seq));
		break;
	case IPPROTO_UDP:
		strcpy(l4_str, "UDP");
		break;
	case IPPROTO_ICMP:
		strcpy(l4_str, "ICMP");
		break;
	default:
		strcpy(l4_str, "");
	}

	printf("%lld.%06lld %s %s:%d > %s:%d %s, length %d\n",
	       timestamp / NS_IN_SEC, (timestamp % NS_IN_SEC) / 1000,
	       l3_str,
	       src_str, ntohs(meta.port16[0]),
	       dst_str, ntohs(meta.port16[1]),
	       l4_str, meta.data_len);
}

int policy_change_black_list(__u32 ip, int action)
{
	int err;

	//============================================================
	int black_list_map;

	black_list_map = open_bpf_map_file(pin_dir, "black_list", &info);
	if (black_list_map < 0) {
		return EXIT_FAIL_BPF;
	}

	/* check map info, e.g. datarec is expected size */
	map_expect.key_size    = sizeof(__u32);
	map_expect.value_size  = sizeof(__u32);

	err = check_map_fd_info(&info, &map_expect);
	if (err) {
		fprintf(stderr, "ERR: map via FD not compatible\n");
		return err;
	}
	//==========================================================
	char src_str[INET_ADDRSTRLEN];
	inet_ntop(AF_INET, &ip, src_str, INET_ADDRSTRLEN);
	if(action == BLOCK)
	{
		unsigned int nr_cpus = bpf_num_possible_cpus();
		__u32 values[nr_cpus];
		memset(values, 0, sizeof(__u32)*nr_cpus);
		int res = bpf_map_update_elem(black_list_map, &ip, values, BPF_ANY);
		if(res == 0)
		{
			printf("[ADDED] IP: %s to BLACK LIST\n", src_str);
		}
	}
	else if (action == UNBLOCK)
	{
		int res = bpf_map_delete_elem(black_list_map, &ip);
		if(res == 0)
		{
			printf("[REMOVED] IP: %s from BLACK LIST\n", src_str);
		}
	}
	else
	{
		printf("[ERROR] Action not found\n");
		return 1;
	}

	return 0;
}

int detect_attackers()
{	
	int i, j, k, g;
	struct policy_stats_ip psi[policy_len];
	int num_ip = 0;
	int flag = 0;
	for(i = 0; i < policy_len; i++)
	{
		psi[i].num_ip = 0;
	}
	// Duyet qua tung packet
	for (i = 0; i < packets_queue_len; i++)
	{
		// Duyet qua tung policy
		for(j = 0; j < policy_len; j++)
		{
			// Phat hien IP dich nam trong policy
			if(packets_queue[i].meta.dst == list_policy[j].ip)
			{
				//Khi mang khong trong
				for(k = 0; k < psi[j].num_ip; k++)
				{
					if(packets_queue[i].meta.src == psi[j].ip[0][k])
					{
						psi[j].ip[1][k] += 1;
						flag = 1;
						break;
					}
				}
				//Neu IP khong ton tai trong mang
				if(flag == 0)
				{
					psi[j].ip[0][num_ip] = packets_queue[i].meta.src;
					psi[j].ip[1][num_ip] = 1;
					num_ip += 1;
				}
				flag = 0;
				psi[j].num_ip = num_ip;
			}
		}
	}

	for(i = 0; i < policy_len; i++)
	{
		for(j = 0; j<psi[i].num_ip; j++)
		{
			//Duyet cac policy co IP
			if(psi[i].num_ip != 0 )
			{
				//Xu ly IP vi pham
				if((psi[i].ip[1][j]/INTERVAL) > list_policy[i].threshold)
				{
					unsigned long now = (unsigned long)time(NULL);
					char src_str[INET_ADDRSTRLEN];
					char dst_str[INET_ADDRSTRLEN];
					inet_ntop(AF_INET, &psi[i].ip[0][j], src_str, INET_ADDRSTRLEN);
					inet_ntop(AF_INET, &list_policy[i].ip, dst_str, INET_ADDRSTRLEN);
					printf("[DETECTED] policy.id: %d, source.ip: %s, destination.ip: %s, event.reason: sent %d(pps) > %d(pps)\n",	\
							list_policy[i].id, src_str, dst_str, psi[i].ip[1][j]/INTERVAL, 											\
							list_policy[i].threshold);										
					//Block IP
					policy_change_black_list(psi[i].ip[0][j], BLOCK);
					for(g = 0; g < IP_DYNAMIC; g++)
					{
						//Vi tri chua co IP
						if(count_down[0][g] == 0)
						{
							count_down[0][g] = psi[i].ip[0][j];
							count_down[1][g] = now;
							break;
						}
					}
				}
			}
		}
	}

	memset(psi, 0, sizeof(psi));
	return 0;
}

int policy_stats(struct perf_event_sample *sample)
{
	// meta_print(sample->meta, sample->timestamp);

	//Ghi thong tin goi in
	packets_queue[packets_queue_len].meta = sample->meta;
	packets_queue_len++;

	return LIBBPF_PERF_EVENT_CONT;
}

static enum bpf_perf_event_ret event_received(void *event, void *printfn)
{
	int (*print_fn)(struct perf_event_sample *) = printfn;
	struct perf_event_sample *sample = event;

	if (sample->header.type == PERF_RECORD_SAMPLE)
		return print_fn(sample);
	else
		return LIBBPF_PERF_EVENT_CONT;
}

int event_poller(struct perf_event_mmap_page **mem_buf, int *sys_fds,
		 int cpu_total)
{
	struct pollfd poll_fds[MAX_CPU];
	void *buf = NULL;
	size_t len = 0;
	int total_size;
	int pagesize;
	int res;
	int n;

	/* Create pollfd struct to contain poller info */
	for (n = 0; n < cpu_total; n++) {
		poll_fds[n].fd = sys_fds[n];
		poll_fds[n].events = POLLIN;
	}

	pagesize = getpagesize();
	total_size = PAGE_CNT * pagesize;
	for (;;) {
		/* Poll fds for events, 250ms timeout */
		poll(poll_fds, cpu_total, 250);

		//==================================================
		// Bat dau tinh thoi gian
		unsigned long now = (unsigned long)time(NULL);
		if(time_start == 0 || prev_time == 0)
		{
			time_start = now;
			prev_time = now;
		}

		//Gan thoi gian bat goi tin
		time_end = now;

		//Bat va xu ly cac goi tin trong khoang thoi gian xac dinh
		if ((time_end - time_start) == INTERVAL)
		{
			//Kiem tra vi pham chinh sach
			detect_attackers();

			//Reset thong ke goi tin
			time_start = time_end;
			memset(packets_queue, 0, sizeof(packets_queue));
			packets_queue_len = 0;
		}

		//Dinh ky moi giay quet trang thai Block 1 lan
		if((time_end - prev_time) == 1)
		{
			for(int i = 0; i < IP_DYNAMIC; i++)
			{
				if(count_down[0][i] != 0)
				{
					//Bo qua neu IP chua het thoi gian khoa
					if((now - count_down[1][i]) < LOCK_TIME)
						continue;

					//Unlock IP het thoi gian khoa
					policy_change_black_list(count_down[0][i], UNBLOCK);
					//Xoa IP khoi danh sach 
					count_down[0][i] = 0;
				}
			}
			prev_time = time_end;
		}
		//==================================================

		for (n = 0; n < cpu_total; n++) {
			if (poll_fds[n].revents) { /* events found */
				res = bpf_perf_event_read_simple(mem_buf[n],
								 total_size,
								 pagesize,
								 &buf, &len,
								 event_received,
								 policy_stats);
				if (res != LIBBPF_PERF_EVENT_CONT)
					break;
			}
		}
	}
	free(buf);
}

int setup_perf_poller(int perf_map_fd, int *sys_fds, int cpu_total,
		      struct perf_event_mmap_page **mem_buf)
{
	struct perf_event_attr attr = {
		.sample_type	= PERF_SAMPLE_RAW | PERF_SAMPLE_TIME,
		.type		= PERF_TYPE_SOFTWARE,
		.config		= PERF_COUNT_SW_BPF_OUTPUT,
		.wakeup_events	= 1,
	};
	int mmap_size;
	int pmu;
	int n;

	mmap_size = getpagesize() * (PAGE_CNT + 1);

	for (n = 0; n < cpu_total; n++) {
		/* create perf fd for each thread */
		pmu = sys_perf_event_open(&attr, -1, n, -1, 0);
		if (pmu < 0) {
			printf("error setting up perf fd\n");
			return 1;
		}
		/* enable PERF events on the fd */
		ioctl(pmu, PERF_EVENT_IOC_ENABLE, 0);

		/* give fd a memory buf to write to */
		mem_buf[n] = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
				  MAP_SHARED, pmu, 0);
		if (mem_buf[n] == MAP_FAILED) {
			printf("error creating mmap\n");
			return 1;
		}
		/* point eBPF map entries to fd */
		assert(!bpf_map_update_elem(perf_map_fd, &n, &pmu, BPF_ANY));
		sys_fds[n] = pmu;
	}
	return 0;
}

int load_policy()
{
    policy_len = 0;
    int id;
    char ip[20];
    int threshold;

    FILE *fp = fopen(POLICIES_FILE, "r");
    if(fp == NULL)
    {
        printf("[ERROR] Can't open file");
        return 1;
    }
    int err = fscanf(fp, "%d %s %d\n", &id, ip, &threshold);
    if(err >0 )
    {
        printf("Loading policy...\n");
        list_policy[policy_len].id = id;
        inet_pton(AF_INET, ip, &list_policy[policy_len].ip);
		if(!err)
		{
			printf("[Error] Can't convert IP string\n");
			return 1;
		}
        list_policy[policy_len].threshold = threshold;
        printf("ID: %d\tIP: %s\tTHRESHOLD: %d(pps)\n", id, ip, threshold);
        policy_len++;

        while (fscanf(fp, "%d %s %d\n", &id, ip, &threshold) != EOF)
        {
            list_policy[policy_len].id = id;
            inet_pton(AF_INET, ip, &list_policy[policy_len].ip);
			if(!err)
			{
				printf("[Error] Can't convert IP string\n");
				return 1;
			}
            list_policy[policy_len].threshold = threshold;
			printf("ID: %d\tIP: %s\tTHRESHOLD: %d(pps)\n", id, ip, threshold);
            policy_len++;
        }
    }
    fclose(fp);

    return 0;
}

int main(int argc, char **argv)
{
	int len, err;

	memset(count_down, 0, sizeof(count_down));

	//=====================================================
	static struct perf_event_mmap_page *mem_buf[MAX_CPU];

	int sys_fds[MAX_CPU];
	int perf_map_fd;
	int n_cpus;
	// int opt;

	xdp_flags = XDP_FLAGS_SKB_MODE; /* default to DRV */
	n_cpus = get_nprocs();
	//======================================================

	struct config cfg = {
		.ifindex   = -1,
		.do_unload = false,
	};

	/* Cmdline options can change progsec */
	parse_cmdline_args(argc, argv, long_options, &cfg, __doc__);

	/* Required option */
	if (cfg.ifindex == -1) {
		fprintf(stderr, "ERR: required option --dev missing\n\n");
		usage(argv[0], __doc__, long_options, (argc == 1));
		return EXIT_FAIL_OPTION;
	}

	/* Use the --dev name as subdir for finding pinned maps */
	len = snprintf(pin_dir, PATH_MAX, "%s/%s", pin_basedir, cfg.ifname);
	if (len < 0) {
		fprintf(stderr, "ERR: creating pin dirname\n");
		return EXIT_FAIL_OPTION;
	}

	perf_map_fd = open_bpf_map_file(pin_dir, "perf_map", &info);
	if (perf_map_fd < 0) {
		return EXIT_FAIL_BPF;
	}

	/* check map info, e.g. datarec is expected size */
	map_expect.key_size    = sizeof(__u32);
	map_expect.value_size  = sizeof(__u32);

	err = check_map_fd_info(&info, &map_expect);
	if (err) {
		fprintf(stderr, "ERR: map via FD not compatible\n");
		return err;
	}
	if (verbose) {
		printf("\nCollecting stats from BPF map\n");
		printf(" - BPF map (bpf_map_type:%d) id:%d name:%s"
		       " key_size:%d value_size:%d max_entries:%d\n",
		       info.type, info.id, info.name,
		       info.key_size, info.value_size, info.max_entries
		       );
	}

	err = load_policy();
	if (err)
	{
		printf("Can't load policy\n");
		return err;
	}

	/* Initialize perf rings */
	if (setup_perf_poller(perf_map_fd, sys_fds, n_cpus, &mem_buf[0]))
		return -1;
	
	event_poller(mem_buf, sys_fds, n_cpus);

	return EXIT_OK;
}
