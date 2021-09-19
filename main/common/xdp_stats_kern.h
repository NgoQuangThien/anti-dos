#ifndef __XDP_STATS_KERN_H
#define __XDP_STATS_KERN_H

#ifndef __XDP_STATS_KERN_USER_H
#warning "You forgot to #include <xdp_stats_kern_user.h>"
#include <xdp_stats_kern_user.h>
#endif

#ifndef __POLICY_STRUCT_KERN_USER_H
#warning "You forgot to #include <policy_struct_kern_user.h>"
#include <policy_struct_kern_user.h>
#endif

/* Keeps stats per (enum) xdp_action */
struct bpf_map_def SEC("maps") xdp_stats_map = {
	.type        = BPF_MAP_TYPE_PERCPU_ARRAY,
	.key_size    = sizeof(__u32),
	.value_size  = sizeof(struct datarec),
	.max_entries = XDP_ACTION_MAX,
};

struct bpf_map_def SEC("maps") perf_map = {
	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
	.key_size = sizeof(__u32),
	.value_size = sizeof(__u32),
};

static __always_inline
__u32 xdp_stats_record_action(struct xdp_md *ctx, __u32 action, struct pkt_meta pkt)
{
	if (action >= XDP_ACTION_MAX)
		return XDP_ABORTED;

	struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
	if (!rec)
		return XDP_ABORTED;

	//Tinh so goi tin, so bytes da nhan
	rec->rx_packets++;
	rec->rx_bytes += (ctx->data_end - ctx->data);

	//Gui thong tin nhung goi PASS len Userspace program
	if (action != XDP_PASS)
		goto out;
	
	bpf_perf_event_output(ctx, &perf_map,
					(__u64)pkt.pkt_len << 32 | BPF_F_CURRENT_CPU,
					&pkt, sizeof(pkt));

out:
	return action;
}

#endif /* __XDP_STATS_KERN_H */
