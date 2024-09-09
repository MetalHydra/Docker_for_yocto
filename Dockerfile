FROM ubuntu:22.04

ENV USER_ID=1001
ENV GROUP_ID=1001
ENV USER="dev"
ENV GROUP="dev"
ENV PASSWD="docker"
ENV WORKDIR=/home/${USER}/yocto

RUN apt-get update && apt-get -y install gawk wget git-core \
    diffstat unzip texinfo gcc-multilib build-essential \
    chrpath socat cpio python3 python3-pip \
    python3-pexpect xz-utils debianutils iputils-ping \
    libsdl1.2-dev tar xterm locales iproute2 file iptables zstd liblz4-tool sudo 

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

 RUN groupadd -g ${GROUP_ID} ${USER} && \
       useradd -g ${GROUP_ID} -ms /bin/bash -u ${USER_ID} ${USER}

RUN echo "${USER}:${PASSWD}" | chpasswd && adduser $USER sudo


RUN mkdir -p ${WORKDIR} && \
    chown -R $USER:$GROUP_ID $WORKDIR

USER ${USER}

WORKDIR ${WORKDIR}



