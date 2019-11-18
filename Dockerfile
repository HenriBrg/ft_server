FROM debian:buster
COPY srcs/nginx.conf /etc/nginx/sites-available/
COPY srcs/wordpress.zip /var/www/
COPY srcs/wordpress.sql /var/www/
COPY srcs/run.sh .
