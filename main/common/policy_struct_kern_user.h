#ifndef __POLICY_STRUCT_KERN_USER_H
#define __POLICY_STRUCT_KERN_USER_H

//struct cho check rules
struct packet_rec {
    __u8 protocol;
    __u32 src_addr;
    __u32 dest_addr;
    __u16 tot_len;
    __u8 ip_flags[3];
    __u16 frag_off;
    __u8 tcp_flags[6];
};

//struct gui to BPF den userspace
struct pkt_meta {
	union {
		__be32 src;
	};
	union {
		__be32 dst;
	};
	__u16 port16[2];
	__u16 l3_proto;
	__u16 l4_proto;
	__u16 data_len;
	__u16 pkt_len;
	__u32 seq;
};

#endif /* __POLICY_STRUCT_KERN_USER_H */
