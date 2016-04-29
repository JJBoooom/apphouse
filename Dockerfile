FROM  centos:7

RUN yum install -y \
    curl \
    python \
    docker


#RUN curl -s -L https://get.docker.com/builds/Linux/x86_64/docker-1.9.1 > /usr/bin/docker; chmod +x /usr/bin/docker

RUN curl -s https://bootstrap.pypa.io/get-pip.py > get-pip.py && python get-pip.py && rm get-pip.py

RUN curl -s http://stedolan.github.io/jq/download/linux64/jq  >/usr/bin/jq && chmod +x /usr/bin/jq

RUN pip install virtualenv
RUN mkdir /venv
RUN cd /venv
RUN virtualenv venv && source /venv/bin/activate && pip install docker-compose && pip install docker-py #&& /venv/bin/deactivate
ENV VENV_BIN /venv/bin
#RUN export PATH=$PATH:/venv/bin/docker-compose
RUN mkdir -p /var/lib/registry_Deploy
COPY ./registry_Deploy  /var/lib/registry_Deploy

ENV DEPLOY_PATH /var/lib/registry_Deploy
RUN chmod +x /var/lib/registry_Deploy/setenv.sh

#COPY ./start.sh /var/lib/registry_Deploy/
RUN chmod +x /var/lib/registry_Deploy/start.sh

#VOLUME ["/var/run/docker.sock"]
#VOLUME ["/var/lib/registry_Deploy/config"]
#VOLUME ["/var/lib/docker"]

ENTRYPOINT ["/var/lib/registry_Deploy/start.sh"]

