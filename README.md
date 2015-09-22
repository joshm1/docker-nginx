# About

Nginx **1.9.4** compiled from source with the [nginx\_upstream\_check\_module](https://github.com/yaoweibin/nginx_upstream_check_module).

This uses a basic `nginx.conf` config. You can mount `/etc/nginx` if you need to override it. If it works for you, mount to `/etc/nginx/conf.d` to supply your own nginx config.

Hosted on [hub.docker.com/r/joshm1/nginx/](https://hub.docker.com/r/joshm1/nginx/)

# Usage

```
docker run -p 80 -p 443 -v /path/to/conf.d:/etc/nginx/conf.d joshm1/nginx
```
