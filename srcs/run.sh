# https://www.cyberciti.biz/faq/how-to-install-lamp-on-debian-10-buster/

sudo apt-get update
sudo apt-get upgrade

sudo apt	 -y install php
sudo apt-get -y install nginx
sudo apt-get -y install php-mysql
sudo apt-get -y install mariadb-server

# NGINX SET UP via https://www.linuxbabe.com/debian/install-lemp-stack-debian-10-buster
# https://www.linode.com/docs/web-servers/nginx/how-to-configure-nginx/
cp nginx.conf /etc/nginx/nginx.conf
