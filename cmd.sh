#!/bin/bash

function usage {
    cat <<EOF
$(basename ${0}) is used for EPGStation docker-compose

Usage:
    $(basename ${0}) [command]

Arguments:
    start           Start EPGStation docker container
    stop            Stop EPGStation docker container
    restart         Restart EPGStation docker container
    logs            Show logs of EPGStation docker container

    setup           Delete config files and generate new config files from template
                    It may be lost your settings
EOF
}

################

project_name='epgstation'
compose_file='docker-compose.yml'

mirakurun_host=$(cat misc.conf | grep mirakurun_host | sed -r 's/^\s*mirakurun_host\s(.+)\s*$/\1/')

export MIRAKURUN_IP=$(getent ahosts ${mirakurun_host} | grep STREAM | grep -v : | sed -r 's/^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*$/\1/')

if [ -z $1 ]; then
    usage
    exit 1
fi

if [ $1 = 'start' ]; then
    echo 'Start EPGStation'
    docker-compose -p ${project_name} -f ${compose_file} up -d
fi

if [ $1 = 'stop' ]; then
    echo 'Stop EPGStation'
    docker-compose -p ${project_name} -f ${compose_file} stop
fi

if [ $1 = 'restart' ]; then
    echo 'Restart EPGStation'
    docker-compose -p ${project_name} -f ${compose_file} stop
    docker-compose -p ${project_name} -f ${compose_file} up -d
fi

if [ $1 = 'logs' ]; then
    docker-compose -p ${project_name} -f ${compose_file} logs epgstation
fi

if [ $1 = 'setup' ]; then
    echo 'Generate config files'
    
    cp docker-compose-sample.yml docker-compose.yml
    cp epgstation/config/enc.js.template epgstation/config/enc.js
    cp epgstation/config/config.yml.template epgstation/config/config.yml
    cp epgstation/config/operatorLogConfig.sample.yml epgstation/config/operatorLogConfig.yml
    cp epgstation/config/epgUpdaterLogConfig.sample.yml epgstation/config/epgUpdaterLogConfig.yml
    cp epgstation/config/serviceLogConfig.sample.yml epgstation/config/serviceLogConfig.yml
fi
