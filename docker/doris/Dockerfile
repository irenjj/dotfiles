FROM apache/doris:build-env-ldb-toolchain-latest
SHELL ["/bin/bash", "-c"]

# yum install
RUN yum -y install mysql sudo

RUN groupadd -g 1001 renjj && \
  adduser -d /home/renjj -u 1000 -g 1001 renjj && \
  echo '12345678' | passwd --stdin renjj && \
  echo "renjj ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chown -R renjj:renjj /var/local/ldb-toolchain && \
  chown -R renjj:renjj /var/local/thirdparty
WORKDIR /home/renjj/work/code/doris
USER renjj
