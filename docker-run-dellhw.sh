#!/bin/bash

docker build -t custom_debian_repo .

docker run --rm -it \
    --entrypoint /opt/custom-debian-repo/bin/apt-repo-custom-source-download-and-create-repo.sh \
    --mount type=bind,source=/opt/custom-debian-repo/config/,target=/opt/custom-debian-repo/config \
    --mount type=bind,source=/opt/iso-and-repo/repos/,target=/opt/repos \
    --network repo \
    custom_debian_repo \
    -f /opt/custom-debian-repo/config/dell-srvadmin-packages.txt  \
    -s /opt/custom-debian-repo/config/dell.sources.list \
    -r /opt/iso-and-repo/iso-and-repo/repos/dell/11100/ \
    -d -n
