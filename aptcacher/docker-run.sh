#!/bin/bash

docker build -t aptcacher .
docker run --rm -d --network repo --name aptcacher -p 3142:3142 -v /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng aptcacher
