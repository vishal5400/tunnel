#!/bin/bash
port_number() {
    local port=8000
    while netstat -ant | grep -q ":$port "; do
        ((port++))
    done
    echo $port
}

port_number
