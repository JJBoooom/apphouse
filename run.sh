#! /bin/bash


docker run --privileged=true -it \
    -e HOST_IP="192.168.12.22" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/kiongf/watch/auth/config:/var/lib/registry_Deploy/install/config \
    -v /home/kiongf/watch/auth/storage:/var/lib/registry_Deploy/install/storage \
    -v /var/lib/docker:/var/lib/docker \
    apphouse:0.0.5
   # --entrypoint=/bin/bash \
   # apphouse:0.0.1
   # -e AUTH_IMAGE=
   # -e UI_IMAGE=
   # -e REGISTRY_IMAGE=
