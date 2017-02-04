#!/bin/bash

cd "$(dirname "$0")"
./migrate.sh &

/usr/bin/monit -d 10 -Ic /etc/monitrc
