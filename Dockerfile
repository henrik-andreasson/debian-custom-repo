FROM debian:bookworm

WORKDIR /build
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142";'   > /etc/apt/apt.conf.d/00cacher
RUN echo 'Acquire::https::Proxy "https://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/00cacher

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y \
    unzip  wget bash xorriso ruby ruby-rubygems \
    apt-rdepends sudo apt-utils \
    gnupg2 xz-utils

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN gem install fpm

RUN mkdir -p /build

RUN mkdir -p        /build/bin
RUN mkdir -p        /build/config

RUN groupadd -g 1001 builder 
RUN useradd -m -u 1001 -g builder builder
RUN echo '%builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder

COPY bin/*         /build/bin
COPY config/*      /build/config

RUN chown -R builder:builder /build
RUN echo "hello"
USER builder

ENTRYPOINT ["/build/bin/apt-repo-custom-source-download-and-create-repo.sh"]
