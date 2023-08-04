#include <linux/types.h>

#include <linux/bpf.h>

#include <bpf/bpf_helpers.h>


#ifdef asm_volatile_goto
    #undef asm_volatile_goto
#endif
#define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")


SEC("tracepoint/syscalls/sys_enter_execve")
int hello_world(void *ctx) {
    const char *msg = "Hello, World!\n";
    bpf_trace_printk(msg, sizeof("Hello, World!\n"));
    return 0;
}
