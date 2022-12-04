FROM archlinux:latest
RUN pacman -Sy --noconfirm
RUN pacman -Syu --noconfirm
RUN pacman -Syy --noconfirm
RUN pacman -S git qemu gcc nasm sudo --noconfirm --needed
RUN rm -rf /os
RUN git clone https://github.com/lochyj/OS.git
RUN cd OS
RUN ./docker.sh
EXPOSE 5900