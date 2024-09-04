.PHONY: install attach

CONTAINER_NAME := ubuntu-x64-cpu
DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

all:

install:
	docker build --platform linux/amd64 -t $(CONTAINER_NAME) .

attach:
	docker run --platform linux/amd64 -it --rm -v $(DIR):/shared $(CONTAINER_NAME)

boot: 
	docker run --platform linux/amd64 -it --rm -v $(DIR):/shared $(CONTAINER_NAME) make -f docker.mk 
	qemu-system-x86_64 -no-reboot -drive file=build/boot_image,format=raw,index=0,media=disk
