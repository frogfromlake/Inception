#!/bin/bash

set -ex

ping -c 1 mariadb &> /dev/null;

echo "hallo"

while [ $? -eq 0 ]
do
        sleep 5;
        ping -c 1 mariadb &> /dev/null;
done
