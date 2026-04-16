#!/bin/bash

/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng

sleep 5
ip addr show
ss -lnt

tail -F /var/log/apt-cacher-ng/*log
