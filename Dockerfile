FROM benmayne/docker-cdh5-dev

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD sshd_config /etc/ssh/

RUN mkdir -p /share
RUN mkdir -p /local

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y sudo byobu docker-engine python3-pip bash-completion s3cmd awscli

RUN mkdir -p /etc/service/docker
ADD docker.sh /etc/service/docker/run

#new things
RUN apt-get install -y htop mosh silversearcher-ag jq

# dqm3
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
RUN apt-get update
RUN apt-get install -y sbt

# dqm2
RUN apt-get install -y r-base-core
RUN apt-get install -y libcurl4-openssl-dev

# Existence
RUN apt-get install -y libfreetype6-dev liblas-dev liblapack-dev gfortran

#cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/home","/share", "/local"]
