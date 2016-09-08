#!/bin/bash

mkdir /tmp/clusterbrake

if [ ! -f ${CB_CONFIG} ];then
        cp ${CB_DEFAULT_DIR}/clusterbrake.properties ${CB_CONFIG}
fi
if [ ! "$(ls -A ${CB_CONFIG_DIR})" ];then
	echo "${CB_CONFIG_DIR} is empty. Copying defaults..."
        mkdir -p ${CB_CONFIG_DIR}
        cp -R ${CB_DEFAULT_DIR}/* ${CB_CONFIG_DIR}/
fi

cd ${CB_DIR}

java -jar clusterbrake-${CB_VERSION}.jar ${CB_CONFIG}

