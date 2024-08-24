CONTAINER_NAME := ubuntu-x64-cpu
DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

install:
	docker build -t $(CONTAINER_NAME) .

attach:
	docker run -it --rm -v $(DIR):/shared $(CONTAINER_NAME)