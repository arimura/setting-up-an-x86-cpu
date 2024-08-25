.PHONY: install attach

CONTAINER_NAME := ubuntu-x64-cpu
DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all:

install:
	docker build -t $(CONTAINER_NAME) .

attach:
	docker run -it --rm -v $(DIR):/shared $(CONTAINER_NAME)

boot: 
	qemu-system-x86_64 -no-reboot -drive file=build/boot_image,format=raw,index=0,media=disk
