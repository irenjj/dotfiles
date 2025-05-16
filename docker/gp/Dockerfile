# 基础镜像，指定使用arm64架构(适用于M1芯片)
FROM --platform=linux/arm64 ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本工具和依赖
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    build-essential \
    cmake \
    gdb \
    vim \
    python3 \
    python3-pip \
    openjdk-11-jdk \
    maven \
    sudo \
	bison \
	ccache \
	flex \
	git-core \
	gcc \
	g++ \
	inetutils-ping \
	krb5-kdc \
	krb5-admin-server \
	libapr1-dev \
	libbz2-dev \
	libcurl4-gnutls-dev \
	libevent-dev \
	libkrb5-dev \
	libpam-dev \
	libperl-dev \
	libreadline-dev \
	libssl-dev \
	libxerces-c-dev \
	libxml2-dev \
	libyaml-dev \
	libzstd-dev \
	locales \
	net-tools \
	ninja-build \
	openssh-client \
	openssh-server \
	openssl \
	pkg-config \
	python3-dev \
	python3-psutil \
	python3-pygresql \
	python3-yaml \
	zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install conan

RUN sudo sysctl -p

# 创建工作目录并设置权限
WORKDIR /root/

# 切换到非root用户
USER root

RUN echo 'kernel.yama.ptrace_scope = 0' > /etc/sysctl.d/10-ptrace.conf

RUN mkdir -p /run/sshd && chmod 0755 /run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
