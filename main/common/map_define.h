#ifndef __MAP_DEFINE_H
#define __MAP_DEFINE_H

#define MAX_CPU 128

#include <linux/bpf.h>

struct bpf_map_def SEC("maps") white_list = {
	.type        = BPF_MAP_TYPE_PERCPU_HASH,
	.key_size    = sizeof(__u32),
	.value_size  = sizeof(__u32),
	.max_entries = 10000,
	.map_flags   = BPF_F_NO_PREALLOC,
};

struct bpf_map_def SEC("maps") black_list = {
	.type        = BPF_MAP_TYPE_PERCPU_HASH,
	.key_size    = sizeof(__u32),
	.value_size  = sizeof(__u32),
	.max_entries = 10000,
	.map_flags   = BPF_F_NO_PREALLOC,
};

#endif /* __MAP_DEFINE_H */
