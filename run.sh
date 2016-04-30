#! /bin/bash


docker run --privileged=true -it \
    -e HOST_IP="192.168.12.22" \
    -e AUTH_IMAGE="index.alauda.cn/cloudsoar/registry_collector_auth:0.8.6" \
    -e UI_IMAGE="index.alauda.cn/cloudsoar/registry_ui:test" \
    -e REGISTRY_IMAGE="index.alauda.cn/oudsoar/registry:2.3.0" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/kiongf/watch/auth/config:/var/lib/registry_Deploy/install/config \
    -v /home/kiongf/watch/auth/storage:/var/lib/registry_Deploy/install/storage \
    -v /var/lib/docker:/var/lib/docker \
     --entrypoint=/bin/bash \
    apphouse:0.0.5 
   # apphouse:0.0.1
