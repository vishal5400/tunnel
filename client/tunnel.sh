#!/bin/bash
Remote_server=$4
Remote_port=$2
Passd=$1
Local_port=$3


sshpass -p "$Passd" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -fN -R $Remote_port:0.0.0.0:$Local_port tunnel@$Remote_server

if [ $? -eq 0 ]; then
    echo "connections established"
else
    echo "Connection Failed."
fi
