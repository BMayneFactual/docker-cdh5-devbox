FROM factual/docker-cdh5-dev

RUN rm -f /etc/service/sshd/down
ADD sshd_config /etc/ssh/
RUN mkdir -p /share
VOLUME ["/home","/share"]