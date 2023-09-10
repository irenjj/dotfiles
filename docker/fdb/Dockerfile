FROM foundationdb/devel:centos7-latest
SHELL ["/bin/bash", "-c"]

RUN yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

RUN yum -y install sudo openssh-server initscripts

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
  ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
  ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

RUN usermod -u 1001 dockremap &&\
  groupmod -g 1001 dockremap

RUN echo '12345678' | passwd --stdin root && \
  echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN groupadd -g 1000 renjj && \
  adduser -d /home/renjj -u 1000 -g 1000 renjj && \
  echo '12345678' | passwd --stdin renjj && \
  echo "renjj ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/renjj
USER renjj

