FROM nginx:1.23.1

LABEL maintainer="jan.wielemans@devgem.be"

COPY index.html /usr/share/nginx/html
COPY env-setup.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/env-setup.sh

CMD ["/usr/local/bin/env-setup.sh"]