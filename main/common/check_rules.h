#ifndef __CHECK_RULES_H
#define __CHECK_RULES_H

#include <stddef.h>

#ifndef __POLICY_STRUCT_KERN_USER_H
#warning "You forgot to #include <policy_struct_kern_user.h>"
#include <policy_struct_kern_user.h>
#endif

#define        IP_RF 0x8000                        /* reserved fragment flag */
#define        IP_DF 0x4000                        /* dont fragment flag */
#define        IP_MF 0x2000                        /* more fragments flag */
#define        IP_OFFMASK 0x1fff                /* mask for fragmenting bits */

//Loai bo cac goi tin khong xac dinh < 0
#define CHECK_RET(ret)              \
	do {                            \
		if ((ret) < 0) {            \
			action = XDP_DROP;      \
			goto out;               \
		}                           \
	} while (0)

//Check list
static __always_inline int in_white_list(__u32 src_addr)
{
	if (bpf_map_lookup_elem(&white_list, &src_addr))
		return 1;

	return 0;
}

static __always_inline int in_black_list(__u32 src_addr)
{
	if (bpf_map_lookup_elem(&black_list, &src_addr))
		return 1;

	return 0;
}

// //Kiem tra goi tin bat thuong

//Rules for ICMP
static __always_inline int icmp_fragment(__u16 frag_off)
{
	if(frag_off & bpf_htons(IP_MF | IP_OFFMASK))
		return 1;

	return 0;
}

static __always_inline int icmp_large_packet(__u16 tot_len)
{
	if(bpf_htons(tot_len) > 0x0400)
		return 1;

	return 0;
}

static __always_inline int icmp_stupid(struct packet_rec pkt)
{
	if(icmp_fragment(pkt.frag_off))
	{
		bpf_printk("[DROP] %u ---> %u : Fragmented ICMP Packets\n", bpf_htonl(pkt.src_addr), bpf_htonl(pkt.dest_addr));
		return 1;
	}

	if(icmp_large_packet(pkt.tot_len))
	{
		bpf_printk("[DROP] %u ---> %u : Large ICMP Packets\n", bpf_htonl(pkt.src_addr), bpf_htonl(pkt.dest_addr));
		return 1;
	}

	return 0;
}

//Rules for TCP
static __always_inline int tcp_fragment(__u16 frag_off, __u8 syn_flag)
{
	if((frag_off & bpf_htons(IP_MF | IP_OFFMASK)) && (syn_flag & 0x0001))
		return 1;

	return 0;
}

static __always_inline int tcp_stupid(struct packet_rec pkt)
{
	if(tcp_fragment(pkt.frag_off, pkt.tcp_flags[4]))	
	{
		bpf_printk("[DROP] %u ---> %u : Fragmented TCP Packets\n", bpf_htonl(pkt.src_addr), bpf_htonl(pkt.dest_addr));
		return 1;
	}

	return 0;
}

#endif /* __CHECK_RULES_H */
