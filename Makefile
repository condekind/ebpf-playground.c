# CC = gcc
CC = clang

# LD = ld
# LD = ld.lld
LD = mold
CFLAGS = -I/usr/include -Xclang -disable-O0-optnone -O0 -std=c2x -ggdb
LDFLAGS = -lbpf -L/usr/lib
SRCDIR = src
OBJDIR = obj
ELFDIR = elf

all: $(ELFDIR)/hello_kern.elf


$(OBJDIR):
	mkdir -p $(OBJDIR)

$(ELFDIR):
	mkdir -p $(ELFDIR)

$(OBJDIR)/hello_kern.o: $(SRCDIR)/hello_kern.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $^ -o $@

# (ld) Supported emulations: 	     elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu i386pep i386pe elf64bpf
# (lld) supported targets: 			 aarch64elf, aarch64elfb, aarch64linux, aarch64linuxb, armelf, armelf_linux_eabi, armelfb, armelfb_linux_eabi, elf32_x86_64, elf32btsmip, elf32btsmipn32, elf32loongarch, elf32lppc, elf32lppclinux, elf32lriscv, elf32ltsmip, elf32ltsmipn32, elf32ppc, elf32ppclinux, elf64_amdgpu, elf64_sparc, elf64btsmip, elf64loongarch, elf64lppc, elf64lriscv, elf64ltsmip, elf64ppc, elf_amd64, elf_i386, elf_iamcu, elf_x86_64, msp430elf
# (mold) mold: Supported emulations: elf_i386 elf_x86_64 armelf_linux_eabi aarch64linux aarch64elf elf32lriscv elf32briscv elf64lriscv elf64briscv elf32ppc elf32ppclinux elf64ppc elf64lppc elf64_s390 elf64_sparc m68kelf shlelf_linux elf64alpha
$(ELFDIR)/hello_kern.elf: $(OBJDIR)/hello_kern.o | $(ELFDIR)
	$(LD) $(LDFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm -rf $(OBJDIR) $(ELFDIR)
