#ifndef __PARSING_H
#define __PARSING_H

#include <stddef.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ip.h>
#include <linux/icmp.h>
#include <linux/udp.h>
#include <linux/tcp.h>

struct hdr_cursor {
	void *pos;
};

//Phan tich Ethernet_header va tra ve Ethernet_type
static __always_inline int parse_ethhdr(struct hdr_cursor *nh,
					void *data_end,
					struct ethhdr **ethhdr)
{
	struct ethhdr *eth = nh->pos;
	int hdrsize = sizeof(*eth);

	//Kiem tra kich thuoc goi tin la hop le
	if (eth + 1 > data_end)
		return -1;

	nh->pos += hdrsize;
	*ethhdr = eth;

	return eth->h_proto;
}

static __always_inline int parse_iphdr(struct hdr_cursor *nh,
				       void *data_end,
				       struct iphdr **iphdr)
{
	struct iphdr *iph = nh->pos;
	int hdrsize;
	if (iph + 1 > data_end)
		return -1;

	hdrsize = iph->ihl * 4;
	// Kiem tra hop le
	if(hdrsize < sizeof(*iph))
		return -1;

	//Tinh do dai IP header
	if (nh->pos + hdrsize > data_end)
		return -1;

	nh->pos += hdrsize;
	*iphdr = iph;

	return iph->protocol;
}

static __always_inline int parse_icmphdr(struct hdr_cursor *nh,
					 void *data_end,
					 struct icmphdr **icmphdr)
{
	struct icmphdr *icmph = nh->pos;

	if (icmph + 1 > data_end)
		return -1;

	nh->pos  = icmph + 1;
	*icmphdr = icmph;

	return icmph->type;
}

static __always_inline int parse_udphdr(struct hdr_cursor *nh,
					void *data_end,
					struct udphdr **udphdr)
{
	int len;
	struct udphdr *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	nh->pos  = h + 1;
	*udphdr = h;

	len = bpf_ntohs(h->len) - sizeof(struct udphdr);
	if (len < 0)
		return -1;

	return len;
}

static __always_inline int parse_tcphdr(struct hdr_cursor *nh,
					void *data_end,
					struct tcphdr **tcphdr)
{
	int len;
	struct tcphdr *h = nh->pos;
	if (h + 1 > data_end)
		return -1;

	len = h->doff * 4;
	//Kiem tra goi hop le
	if(len < sizeof(*h))
		return -1;

	//Tinh toan do dai TCP header
	if (nh->pos + len > data_end)
		return -1;

	nh->pos += len;
	*tcphdr = h;

	return len;
}

#endif /* __PARSING_H */
