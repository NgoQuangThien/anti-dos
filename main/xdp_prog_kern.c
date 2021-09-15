/* SPDX-License-Identifier: GPL-2.0 */
#include <stddef.h>
#include <linux/bpf.h>
#include <arpa/inet.h>
// #include <linux/in.h>
#include <stdbool.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>

#include "common/xdp_stats_kern_user.h"
#include "common/policy_struct_kern_user.h"
#include "common/xdp_stats_kern.h"

#include "common/map_define.h"

#include "common/parsing.h"
#include "common/check_rules.h"

#define bpf_printk(fmt, ...)                                    \
({                                                              \
        char ____fmt[] = fmt;                                   \
        bpf_trace_printk(____fmt, sizeof(____fmt),              \
                         ##__VA_ARGS__);                        \
})

SEC("xdp_packet_parser")
int  xdp_parser_func(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	__u32 action = XDP_PASS;	//Default action

	struct hdr_cursor nh;
	nh.pos = data;

	struct ethhdr *eth;
	struct iphdr *iphdr;
	struct tcphdr *tcphdr;
	struct udphdr *udphdr;
	struct icmphdr *icmphdr;

	struct packet_rec pkt = {};
	struct pkt_meta pkt_meta = {};
	int eth_type;
	int ip_type;
	__u32 off = 0;

	//Phan tich Ethernet_header
	eth_type = parse_ethhdr(&nh, data_end, &eth);	
	CHECK_RET(eth_type);	//Kiem tra Ethernet_type

	switch (eth_type)
	{
		//IPv4
		case bpf_htons(ETH_P_IP):
			ip_type = parse_iphdr(&nh, data_end, &iphdr);
			CHECK_RET(ip_type);

			//Kiem tra IP co nam trong WHITE_LIST
			if (in_white_list(iphdr->saddr))
			{
				bpf_printk("[PASS] %u ---> %u : IP in WHITE LIST\n", bpf_htonl(iphdr->saddr), bpf_htonl(iphdr->saddr));
				return XDP_PASS;
			}

			//Kiem tra IP co nam trong BLACK_LIST
			if (in_black_list(iphdr->saddr))
			{
				bpf_printk("[DROP] %u ---> %u IP in BLACK LIST\n", bpf_htonl(iphdr->saddr), bpf_htonl(iphdr->saddr));
				return XDP_DROP;
			}

			pkt.protocol 	= bpf_htons(ip_type);
			pkt.src_addr 	= iphdr->saddr;
			pkt.dest_addr 	= iphdr->daddr;
			pkt.tot_len 	= iphdr->tot_len;
			pkt.frag_off	= iphdr->frag_off;

			switch (ip_type){
			case IPPROTO_TCP:
				CHECK_RET(parse_tcphdr(&nh, data_end, &tcphdr));
				pkt.tcp_flags[4] = tcphdr->syn;
				if(tcp_stupid(pkt))
				{
					action = XDP_DROP;
					goto out;
				}
				//Thong tin goi TCP
				off += sizeof(struct tcphdr);
				pkt_meta.port16[0] = tcphdr->source;
				pkt_meta.port16[1] = tcphdr->dest;
				pkt_meta.seq = tcphdr->seq;
				break;
				
			case IPPROTO_UDP:
				CHECK_RET(parse_udphdr(&nh, data_end, &udphdr));
				//Thong tin goi UDP
				off += sizeof(struct udphdr);
				pkt_meta.port16[0] = udphdr->source;
				pkt_meta.port16[1] = udphdr->dest;
				break;

			case IPPROTO_ICMP:
				parse_icmphdr(&nh, data_end, &icmphdr);
				if(icmp_stupid(pkt))
				{
					action = XDP_DROP;
					goto out;
				}
				off += sizeof(struct icmphdr);
				pkt_meta.port16[0] = 0;
				pkt_meta.port16[1] = 0;
				break;

			default:
				goto out;
				break;
			}
			//Ket thuc xu ly IPv4
			break;

		//IPv6
		case bpf_htons(ETH_P_IPV6):
			goto out;
			break;

		default:
			goto out;
			break;
	}

	//Du lieu cac goi tin PASS
	off += (sizeof(struct ethhdr) + sizeof(struct iphdr));
	pkt_meta.pkt_len = data_end - data;
	pkt_meta.data_len = data_end - data - off;
	pkt_meta.l3_proto = bpf_htons(eth_type);
	pkt_meta.src = iphdr->saddr;
	pkt_meta.dst = iphdr->daddr;
	pkt_meta.l4_proto = iphdr->protocol;

out:
	return xdp_stats_record_action(ctx, action, pkt_meta);
}

char _license[] SEC("license") = "GPL";
