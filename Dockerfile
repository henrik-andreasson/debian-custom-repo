FROM debian:trixie

WORKDIR /build
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y \
    unzip  wget bash xorriso ruby ruby-rubygems apt-rdepends sudo apt-utils gnupg2
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN gem install fpm

RUN mkdir -p /opt/custom-debian-repo

RUN mkdir -p        /opt/custom-debian-repo/bin
RUN mkdir -p        /opt/custom-debian-repo/config
RUN mkdir -p        /opt/repo

# the repo dir must be owned by the builder user in the HOST file system
# since the sync is executed as the builder user, it must have write permissions on the repo dir
RUN groupadd -g 1000 builder ; useradd -m -u 1000 -g builder builder
RUN echo '%builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder

#RUN echo 'Acquire::http::Proxy "http://aptcacher:3142";'   > /etc/apt/apt.conf.d/00cacher
#RUN echo 'Acquire::https::Proxy "http://aptcacher:3142";'   >> /etc/apt/apt.conf.d/00cacher
COPY bin/*         /opt/custom-debian-repo/bin
COPY config/*      /opt/custom-debian-repo/config


RUN chown -R builder /build
RUN echo "hello"
USER builder

RUN apt search srvadmin

ENTRYPOINT ["/opt/custom-debian-repo/bin/apt-repo-custom-source-download-and-create-repo.sh"]
