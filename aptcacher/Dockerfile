FROM debian:stable-slim

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary tools
# fpm requires ruby, rubygems, and some build tools like rpm, dpkg-dev, etc.
# gcc, make, autoconf are standard build tools.
RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-cacher-ng iproute2
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's|Daemon: 1|Daemon: 0|g'  /etc/apt-cacher-ng/acng.conf
COPY start.sh /
RUN chmod +x /start.sh
EXPOSE 3142

# Define default command if any
#CMD ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng"]
CMD ["/start.sh"]
