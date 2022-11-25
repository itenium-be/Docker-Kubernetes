FROM nginx:1.23.1

LABEL maintainer="jan.wielemans@devgem.be"

COPY index.html /usr/share/nginx/html
