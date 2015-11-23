FROM debian:jessie

RUN apt-get update
RUN apt-get install -y debootstrap busybox