static const char *__doc__ = "Anti DoS list update program\n"
	" - Finding map via --dev name info\n";

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <getopt.h>

#include <locale.h>
#include <unistd.h>

#include <bpf/bpf.h>
#include <net/if.h>
#include <linux/if_link.h>

#include "../common/common_params.h"
#include "../common/common_user_bpf_xdp.h"

#include "bpf_util.h" /* bpf_num_possible_cpus */

#include <arpa/inet.h>

static const struct option_wrapper long_options[] = {
	{{"help",        no_argument,		NULL, 'h' },
	 "Show help", false},

	{{"dev",         required_argument,	NULL, 'd' },
	 "Operate on device <ifname>", "<ifname>", true},

	{{0, 0, NULL,  0 }}
};

#ifndef PATH_MAX
#define PATH_MAX	4096
#endif

#ifndef LEN_MAX
#define LEN_MAX		16
#endif

const char *pin_basedir =  "/sys/fs/bpf";

int update_list(int map_fd, char ip_string[20])
{
	unsigned int nr_cpus = bpf_num_possible_cpus();
	__u32 values[nr_cpus];
	__u32 key;
	memset(values, 0, sizeof(__u32)*nr_cpus);
	int res = inet_pton(AF_INET, ip_string, &key);
	if (res <= 0)
	{
		if (res == 0)
		{
			fprintf(stderr, "[Error] ERR: IPv4 \"%s\" not in presentation format\n", ip_string);
		}
		else
			perror("Error: ");
		return 1;
	}

	res = bpf_map_update_elem(map_fd, &key, values, BPF_ANY);
	if(res == 0)
	{
		printf("Done\n");
		return 1;
	}

	return 0;
}

int load_user_map(int map_fd, char file_path[100])
{
    char ip[20];

    FILE *fp = fopen(file_path, "r");
    if(fp == NULL)
    {
        printf("[ERROR] Can't open file");
        return 1;
    }
    int err = fscanf(fp, "%s\n", ip);
    if(err >0 )
    {
        printf("Loading policy...\n");
        printf("IP: %s\n", ip);

		update_list(map_fd, ip);

        while (fscanf(fp, "%s\n", ip) != EOF)
        {
			printf("IP: %s\n", ip);
			update_list(map_fd, ip);
        }
    }
    fclose(fp);

    return 0;
}




int main(int argc, char **argv)
{
	struct bpf_map_info map_expect = { 0 };
	struct bpf_map_info info = { 0 };
	char pin_dir[PATH_MAX];
	int list_map_fd;
	int len, err;

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

	//	Su dung --dev de tm ban do duoc ghim
	len = snprintf(pin_dir, PATH_MAX, "%s/%s", pin_basedir, cfg.ifname);
	if (len < 0) {
		fprintf(stderr, "ERR: creating pin dirname\n");
		return EXIT_FAIL_OPTION;
	}

	//==================================================================
	char file_name[100];
	printf("Enter list name <white_list>/<black_list>: ");
	scanf("%[^\n]", file_name);
	char file_path[100];
	if (strcmp(file_name, "white_list") == 0)
		strcpy(file_path, "list/whitelist");
		
	else if (strcmp(file_name, "black_list") == 0)
		strcpy(file_path, "list/blacklist");

	else{
		printf("Invalid input\n");
		return -1;
	}
	//==================================================================

	list_map_fd = open_bpf_map_file(pin_dir, file_name, &info);
	if (list_map_fd < 0) {
		return EXIT_FAIL_BPF;
	}

	// Kiem tra thon tin map
	map_expect.key_size    = sizeof(__u32);
	map_expect.value_size  = sizeof(__u32);
	map_expect.max_entries = 10000;
	err = check_map_fd_info(&info, &map_expect);
	if (err) {
		fprintf(stderr, "ERR: map via FD not compatible\n");
		return err;
	}
	if (verbose) {
		printf(" BPF map (bpf_map_type:%d) id:%d name:%s"
		       " key_size:%d value_size:%d max_entries:%d\n",
		       info.type, info.id, info.name,
		       info.key_size, info.value_size, info.max_entries
		       );
	}

	load_user_map(list_map_fd, file_path);

	// FILE * fp = fopen(file_path,"r");
	// if (fp == NULL)
	// {
	// 	perror("Error:");
	// 	return -1;
	// }

	// printf("\nUpdating... %s\n\n", file_name);
	// char line[LEN_MAX];
	// do{
	// 	if(!read_and_update(list_map_fd, line, LEN_MAX, fp))
	// 		break;
	// }while(1);

	// fclose(fp);

	return EXIT_OK;
}
