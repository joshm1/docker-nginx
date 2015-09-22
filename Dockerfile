FROM debian:jessie

MAINTAINER Josh McDade "josh.ncsu@gmail.com"

ENV NGINX_VERSION 1.9.4
ENV UPSTREAM_CHECK_MODULE_VERSION 0.3.0

RUN apt-get -qq update && \
  apt-get -y -qq install wget patch build-essential zlib1g-dev libpcre3 libpcre3-dev libbz2-dev libssl-dev tar unzip && \
  cd /tmp && \
  wget -q https://github.com/yaoweibin/nginx_upstream_check_module/archive/v$UPSTREAM_CHECK_MODULE_VERSION.tar.gz && \
  tar xvf v$UPSTREAM_CHECK_MODULE_VERSION.tar.gz && \
  wget -q http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && \
  tar xvf nginx-$NGINX_VERSION.tar.gz && \
  cd /tmp/nginx-$NGINX_VERSION && \
  wget -q https://raw.githubusercontent.com/yaoweibin/nginx_upstream_check_module/master/check_1.9.2%2B.patch && \
  patch -p0 < check_1.9.2+.patch && \
  ./configure --add-module=/tmp/nginx_upstream_check_module-$UPSTREAM_CHECK_MODULE_VERSION \
    --prefix=/etc/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --sbin-path=/usr/local/sbin \
    --pid-path=/var/run/nginx.pid \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log && \
  make && \
  make install && \
  rm -rf /tmp/nginx* && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME ["/var/cache/nginx", "/etc/nginx/conf.d"]

EXPOSE 80 443

CMD ["/usr/local/sbin/nginx", "-g", "daemon off;"]
