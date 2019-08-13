FROM ubuntu:18.04

RUN  apt update
RUN  apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        gnupg-agent \
        python3-pip \
        software-properties-common
RUN  pip3 install awscli
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
RUN  apt update
RUN  apt-get install -y docker-ce docker-ce-cli containerd.io
RUN curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest && \
        chmod +x /usr/local/bin/ecs-cli

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []