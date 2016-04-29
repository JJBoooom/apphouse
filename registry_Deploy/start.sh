#! /bin/bash

# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.
  

set -e


License_display="
--------------------------------------------------------------
Welcome to use AppHouse, you can access private repository via
https://localhost:443 or http://localhost:80.
If you have any questions, please access www.youruncloud.com, 
thanks.
--------------------------------------------------------------"
echo $License_display

docker version
if [ $? -ne 0 ];then 
    echo "server docker version doesn't match apphouse docker version"    
    echo "please install correct docker version "
    exit 1
fi

inspectProg="/var/lib/registry_Deploy/inspect"
configPath=`$inspectProg | cut -d ":" -f1`
storagePath=`$inspectProg | cut -d ":" -f2`
if [ -z $configPath ] || [ -z $storagePath ];then
    echo "can't get ConfigPath or StoragePath"
    echo "please check if you have run container with"
    echo "-v <hostConfigLocation>:/var/lib/registry_Deploy/config and "
    echo "-v <hostStorageLocation>:/var/lib/registry_Deploy/storage"
    exit 1
fi



if [ -z $AUTH_IMAGE ] ;then
    echo "env AUTH_IMAGE is empty; use default auth image"
    export AUTH_IMAGE=index.alauda.cn/cloudsoar/registry_collector_auth:0.8.6
fi

if [ -z $UI_IMAGE ] ;then
    echo "env UI_IMAGE is empty; use default ui image"
    export UI_IMAGE=index.alauda.cn/cloudsoar/registry_ui:test
fi

if [ -z $REGISTRY_IMAGE ]; then 
    echo "env REGISTRY_IMAGE is empty; use default registry image"
    export REGISTRY_IMAGE=index.alauda.cn/cloudsoar/registry:2.3.0
fi

export CONFIG_PATH=$configPath
export STORAGE_PATH=$storagePath

. $DEPLOY_PATH/setenv.sh -ip $HOST_IP 
cd $DEPLOY_PATH/install

$VENV_BIN/docker-compose up



