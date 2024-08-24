# Use the official Ubuntu image as a base
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install NASM and ld (binutils)
RUN apt-get update && \
    apt-get install -y nasm binutils make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory in the container to be shared with the host
RUN mkdir -p /shared

# Set /shared as the working directory
WORKDIR /shared

# Specify the shared volume, this will be mounted from the host
VOLUME ["/shared"]

# Set the default command to run an interactive shell
CMD ["/bin/bash"]
