#!/bin/bash
temp_passd=$1

sudo echo -e "$temp_passd\n$temp_passd" | sudo passwd tunnel
