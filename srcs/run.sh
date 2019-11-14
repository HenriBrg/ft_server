apt-get -y update
apt-get -y upgrade

apt-get -y install wget
apt-get -y install php
apt-get -y install nginx
apt-get -y install php-mysql
apt-get -y install mariadb-server

# NGINX
# Usefull resources :
# 	- https://www.linuxbabe.com/debian/install-lemp-stack-debian-10-buster
# 	- https://www.linode.com/docs/web-servers/nginx/how-to-configure-nginx/
#	- https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04
#	- https://guillaumebriday.fr/comprendre-et-mettre-en-place-docker

cd && mkdir -p /var/www/localhost
cp nginx.conf /etc/nginx/sites/available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
chmod -R 755 /var/www/*

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# MariaDB
# Usefull resources :
# 	- https://www.itzgeek.com/how-tos/linux/debian/how-to-install-phpmyadmin-with-nginx-on-debian-10.html

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
# Inspired by : https://www.itzgeek.com/how-tos/linux/debian/how-to-install-mariadb-on-debian-10.html#nativepassword
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
cd && mysql wordpress -u root --password=  < wordpress.sql

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Wordpress
# Usefull resources :
# 	-

cd && cp wordpress.tar.gz /var/www/localhost/
cd /var/www/localhost/
tar -xf wordpress.tar.gz
rm wordpress.tar.gz

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# SSL on Nginx
# Usefull resources :
# 	- https://www.isicca.com/fr/lemp-installer-nginx-php7-mariadb/#c4

mkdir ~/mkcert
cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert && \
chmod +x mkcert
./mkcert -install
./mkcert localhost

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


# PHPmyAdmin
# Usefull resources :
# 	- https://www.itzgeek.com/how-tos/linux/debian/how-to-install-phpmyadmin-with-nginx-on-debian-10.html
#	- https://docs.phpmyadmin.net/en/latest/setup.html

cd && mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz -C /var/www/localhost/phpmyadmin
cp /root/config.inc.php /var/www/localhost/phpmyadmin/

service mysql restart
/etc/init.d/php7.3-fpm start
service nginx restart
