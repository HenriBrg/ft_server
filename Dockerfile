FROM debian:buster
COPY src/wordpress.sql ./root/
COPY src/nginx.conf ./root/
COPY src/wordpress.tar.gz ./root/
COPY src/config.inc.php ./root/
COPY src/run.sh ./
