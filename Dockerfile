FROM h2g2/docker-xenial

ENV KONG_VERSION 0.11.2

RUN apt-get update && \
	apt-get install -y wget perl

RUN wget https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-$KONG_VERSION.zesty.all.deb -O kong-community-edition-$KONG_VERSION.zesty.all.deb &&\
	dpkg -i kong-community-edition-$KONG_VERSION.zesty.all.deb

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]
