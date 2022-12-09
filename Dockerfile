FROM archlinux:latest
RUN pacman -Sy --noconfirm
RUN pacman -Syu --noconfirm
RUN pacman -Syy --noconfirm
RUN pacman -S git qemu gcc nasm sudo binutils --noconfirm --needed
RUN rm -rf /os
RUN git clone https://github.com/lochyj/OS.git
RUN cd OS && nasm ./boot/kernel_entry.asm -f elf32 -o ./out/kernel-entry.out && nasm ./boot/mbr.asm -f bin -o ./out/mbr.bin && nasm ./kernel/cpu/interrupt.asm -f elf32 -o ./out/asm.out && gcc -m32 -g -fno-pie -ffreestanding -fno-stack-protector -I . -I ./libc -c ./kernel/kernel.c -o ./out/kernel.out && ld -m elf_i386 -shared -fstack-protector -o ./out/kernel.bin -Ttext 0x9000 ./out/kernel-entry.out ./out/asm.out ./out/kernel.out --oformat binary && cat ./out/mbr.bin ./out/kernel.bin > ./out/image/image.img && qemu-system-i386 -fda ./out/image/image.img
EXPOSE 5900