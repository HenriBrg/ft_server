apt-get -y update
apt-get -y upgrade
apt-get -y install zip
apt-get -y install wget
apt-get -y install nginx
apt-get -y install mariadb-server
apt-get -y install php php-cli php-mysql
apt-get -y install php-cgi php-fpm php-mbstring
apt-get -y remove apache2
apt-get -y purge apache2

# ------------------------------------------------------------------------------
# Configuration NGinx
# www-data = user Debian
# ------------------------------------------------------------------------------

ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# ------------------------------------------------------------------------------
# WordPress
# ------------------------------------------------------------------------------

unzip /var/www/wordpress.zip -d /var/www/

# ------------------------------------------------------------------------------
# Création de la DB mySQL
# ------------------------------------------------------------------------------

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
mysql wordpress -u root --password=  < /var/www/wordpress.sql

# ------------------------------------------------------------------------------
# PHP
# ------------------------------------------------------------------------------

/etc/init.d/php7.3-fpm start

# ------------------------------------------------------------------------------
# Certificat SSL
# ------------------------------------------------------------------------------

mkdir ~/mkcert && cd ~/mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
mv mkcert-v1.1.2-linux-amd64 mkcert && chmod +x mkcert
./mkcert -install
./mkcert localhost

service nginx start
