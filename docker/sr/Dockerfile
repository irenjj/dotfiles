FROM starrocks/dev-env-ubuntu
SHELL ["/bin/bash", "-c"]

RUN groupadd -g 20 renjj && \
    useradd -d /home/renjj -u 501 -g 20 -m renjj && \
    echo 'renjj:12345678' | chpasswd && \
    echo "renjj ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    getent group renjj && \
    chgrp -R renjj /var/local/thirdparty && \
    chown -R renjj:renjj /var/local/thirdparty

USER renjj
