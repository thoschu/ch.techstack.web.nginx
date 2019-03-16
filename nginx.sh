### In nginx.sh (make sure this file is chmod +x):
#!/bin/sh

dnsdomainname

## Install NGINX on Ubuntu
sudo su -
apt-get update
apt-get upgrade -y
which nginx
apt-get install nginx -y
nginx -v
systemctl status nginx
service nginx {start|stop|restart|reload|force-reload|status|configtest|rotate|upgrade}

docker run -it -p 80:80 -p 443:443 --name nginx ubuntu bash
docker run --name nginx -v /root/nginx/www/error:/usr/share/nginx/html/error:ro -v /root/nginx/www/server360.io:/usr/share/nginx/html/server360.io:ro -v /root/nginx/www/default_server:/usr/share/nginx/html/default_server:ro -v /root/nginx/conf.d:/etc/nginx/conf.d:ro --link chat:chat -p 80:80 -p 443:443 -d ubuntu


certbot --nginx -d chat.server360.io -d server360.io -d www.server360.io


## NGINX files and directories
cd /etc/nginx 
ls -ltr
cat /etc/nginx/nginx.conf ### main configuration file

cd /etc/nginx/conf.d/
ls /etc/nginx/conf.d/ -ltr

cd /etc/nginx/sites-available/
ls /etc/nginx/sites-available/ -ltr
cat /etc/nginx/sites-available/default

cd /etc/nginx/sites-enabled/
ls /etc/nginx/sites-enabled/ -ltr 
cat /etc/nginx/sites-enabled/default ###symlink to /etc/nginx/sites-available/default

cd /var/log/nginx/
ls /var/log/nginx/ -ltr
cat /var/log/nginx/error.log
cat /var/log/nginx/access.log

cd /var/www/
ls /var/www/ -ltr
ls /var/www/html -ltr


## NGINX cli
systemctl status nginx --no-pager
systemctl stop nginx
systemctl is-active nginx
systemctl start nginx
systemctl is-active nginx
systemctl reload nginx

nginx -h
nginx -t
nginx -T ### entire configuration
nginx -T | less


## Inside nginx.conf
view /etc/nginx/nginx.conf
ls /etc/nginx/sites-enabled/ -ltr
unlink /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# cd /etc/nginx/sites-available/
# ls /etc/nginx/sites-available/ -ltr


## Configure virtual host
cd /etc/nginx/conf.d/
nano /etc/nginx/conf.d/server360.local.conf
nginx -t
systemctl reload nginx
mkdir /var/www/server360.local
echo "Tom S." > /var/www/server360.local/index.html
ls /var/www/server360.local/ -ltr
cat  /var/www/server360.local/index.html
cat  /etc/nginx/conf.d/server360.local.conf

## server360.local.conf
#server {
#        listen 80; ### default_server;
#        server_name ec2-18-184-225-53.eu-central-1.compute.amazonaws.com;
#        index index.htm index.html index.php;
#        root /var/www/server360.local;
#}


## Add files
nano /var/www/server360.local/index.html
	# wget https://raw.githubusercontent.com/cbracco/html5-test-page/master/index.html

apt-get install unzip -y
which unzip

find /var/www/server360.local/ -type f -exec chmod 644 {} \;
find /var/www/server360.local/ -type d -exec chmod 755 {} \;


## Configure locations
mkdir images
cd images 
wget -nd -H -p -A jpg,jpeg,png,gif -e robots=off http://boards.4chan.org/sp/
nano /var/www/server360.local/404.html

#server {
#        listen 80;
#        server_name ec2-18-184-225-53.eu-central-1.compute.amazonaws.com;
#        index index.htm index.html index.php;
#        root /var/www/server360.local;
#
#
#        location / {
#                try_files $uri $uri/ =404;
#        }
#
#        location /images {
#                autoindex on;
#        }
#
#        error_page 404 /404.html;
#        location = /404.html {
#                internal;
#        }
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#                internal;
#        }
#
#        location = /500 {
#                fastcgi_pass unix:/this/will/fail;
#        }
#}


## Configure logs
#access_log /var/log/nginx/server360.local/access.log;
#error_log /var/log/nginx/server360.local/error.log;
#
#server {
#        listen 80;
#        server_name ec2-18-184-225-53.eu-central-1.compute.amazonaws.com;
#        index index.htm index.html index.php;
#        root /var/www/server360.local;
#
#        access_log /var/log/nginx/server360.local.access.log;
#        error_log /var/log/nginx/server360.local.error.log;
#
#        location / {
#                try_files $uri $uri/ =404;
#        }
#
#        location /images {
#                autoindex on;
#                access_log /var/log/nginx/server360.local.images.access.log;
#                error_log /var/log/nginx/server360.local.images.error.log;
#
#        }
#
#        error_page 404 /404.html;
#        location = /404.html {
#                internal;
#        }
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#                internal;
#        }
#
#        location = /500 {
#                fastcgi_pass unix:/this/will/fail;
#        }
#
#}

#for i in {1..10}; do curl localhost > /dev/null; done;


## troubleshooting NGINX
nginx -t
nginx -T
systemctl status nginx
systemctl reload nginx
sudo lsof -P -n -i :80 -i :443 | grep LISTEN
netstat -plan | grep nginx

tail -f /var/log/nginx/*.log


## The LEMP-Stack
apt install php-fpm php-mysql -y
php --version
systemctl status php7.2-fpm
service php7.2-fpm reload
https://www.howtoforge.com/tutorial/installing-nginx-with-php7-fpm-and-mysql-on-ubuntu-16.04-lts-lemp/

#<?php phpinfo(); phpinfo(INFO_MODULES); ?> ### index.php

#server {
#        listen 80;
#        server_name ec2-35-158-139-53.eu-central-1.compute.amazonaws.com;
#        index index.htm index.html index.php;
#        root /var/www/server360.local;
#
#        access_log /var/log/nginx/server360.local.access.log;
#        error_log /var/log/nginx/server360.local.error.log;
#
#
#        location / {
#                try_files $uri $uri/ =404;
#        }
#
#
#        location /images {
#                autoindex on;
#                access_log /var/log/nginx/server360.local.images.access.log;
#                error_log /var/log/nginx/server360.local.images.error.log;
#
#        }
#
#
#        error_page 404 /404.html;
#        location = /404.html {
#                internal;
#        }
#
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#                internal;
#        }
#
#
#        location = /500 {
#                fastcgi_pass unix:/this/will/fail;
#        }
#
#        location ~ \.php$ {
#                include snippets/fastcgi-php.conf;
#                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#                fastcgi_intercept_errors on;
#        }
#}

apt-get install mariadb-server mariadb-client -y
systemctl status mysqld.service
mysql --version

mysql_secure_installation
mysql -u root -p
create database if not exists people;
create user if not exists 'tom' IDENTIFIED BY 'mama123';
grant all on people.* to 'admin'@'localhost' identified by 'admin';
exit


## Secure NGINX
dpkg --list
apt install apache2-utils -y
htpasswd -c /etc/nginx/passwords tom
htpasswd /etc/nginx/passwords thomas
# htpasswd -D /etc/nginx/passwords tini
ls -ltr /etc/nginx/passwords
cat /etc/nginx/passwords
chown www-data /etc/nginx/passwords
chmod 600 /etc/nginx/passwords

which openssl
apt install openssl -y
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -batch
ls -ltr /etc/ssl/private/
ls -ltr /etc/ssl/certs/nginx.crt
https://letsencrypt.org/getting-started/


## Reserve Proxies and Load Balancers
which git
git clone https://github.com/thoschu/de.schulte360.web.snake.git
cd
npm i
npm start
nohup npm start &
nohup node /nodeapp/index.js &

#http {
#	upstream {
#	}
#
#	 server {
#		location {
#		}
#	 }
#}

sudo su -
lsof -i -P -n | grep LISTEN
netstat -tulpn | grep LISTEN
netstat -tulpn | grep LISTEN

 # configuration file /etc/nginx/conf.d/server360.local.conf:
#upstream app_snake_7777 {
#        server 127.0.0.1:7777;
#}
#
#upstream app_snake_round_robin {
#        server 127.0.0.1:7777;
#        server 127.0.0.1:8888;
#        server 127.0.0.1:9999;
#}
#
#upstream app_snake_least_conn {
#        least_conn;
#        server 127.0.0.1:7777;
#        server 127.0.0.1:8888;
#        server 127.0.0.1:9999;
#}
#
#upstream app_snake_ip_hash {
#        ip_hash;
#        server 127.0.0.1:7777;
#        server 127.0.0.1:8888;
#        server 127.0.0.1:9999;
#}
#
#upstream app_snake_weight {
#        server 127.0.0.1:7777;
#        server 127.0.0.1:8888 weight=3;
#        server 127.0.0.1:9999;
#}
#
#server {
#        listen 80;
#        server_name ec2-35-158-139-53.eu-central-1.compute.amazonaws.com;
#        # return 301 https://$server_addr$request_uri;
#        return 301 https://$server_name$request_uri;
#        # return 301 https://$host$request_uri;
#        # return 301 https://ec2-35-158-139-53.eu-central-1.compute.amazonaws.com;
#}
#
#server {
#        listen 443 ssl;
#        ssl_certificate /etc/ssl/certs/nginx.crt;
#        ssl_certificate_key /etc/ssl/private/nginx.key;
#
#        server_name ec2-35-158-139-53.eu-central-1.compute.amazonaws.com;
#        index index.htm index.html index.php;
#        root /var/www/server360.local;
#
#        access_log /var/log/nginx/server360.local.access.log;
#        error_log /var/log/nginx/server360.local.error.log;
#
#
#        location / {
#                # auth_basic "Auth is req...";
#                # auth_basic_user_file /etc/nginx/passwords;
#                try_files $uri $uri/ =404;
#        }
#
#
#        location /snake/ {
#                # trailing is the key
#                proxy_pass http://app_snake_7777/;
#        }
#
#
#        location /roundrobin/ {
#                proxy_pass http://app_snake_round_robin/;
#        }
#
#
#        location /leastconn/ {
#                proxy_pass http://app_snake_least_conn/;
#        }
#
#        location /iphash/ {
#                proxy_pass http://app_snake_ip_hash/;
#        }
#
#
#        location /weight/ {
#                proxy_pass http://app_snake_weight/;
#        }
#
#
#        location /info/ {
#                return 200 $server_name$request_uri;
#        }
#
#        location /images {
#                autoindex on;
#                allow 192.168.0.0/24;
#                allow 10.0.0.0/8;
#                allow 95.90.252.154;
#                deny all;
#                access_log /var/log/nginx/server360.local.images.access.log;
#                error_log /var/log/nginx/server360.local.images.error.log;
#
#        }
#
#         error_page 403 /403.html;
#                location = /403.html {
#                internal;
#        }
#
#        error_page 404 /404.html;
#        location = /404.html {
#                internal;
#        }
#
#        error_page 500 502 503 504 /50x.html;
#        location = /50x.html {
#                internal;
#        }
#
#
#        location = /500 {
#                fastcgi_pass unix:/this/will/fail;
#        }
#
#        location ~ \.php$ {
#                include snippets/fastcgi-php.conf;
#                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#                fastcgi_intercept_errors on;
#        }
#




#                location ~ \.php$ {
#                        include snippets/fastcgi-php.conf;
#                        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#                        fastcgi_intercept_errors on;
#                }
#
#        }
#
#        location /open/ {
#                autoindex on;
#                auth_basic "Auth is req...";
#                auth_basic_user_file /etc/nginx/passwords;
#
#                location ~ \.php$ {
#                        include snippets/fastcgi-php.conf;
#                        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#                        fastcgi_intercept_errors on;
#                }
#
#        }
#
#}

## Libraries
// sweetalert2.js
// howler.js
// cleave.js
// https://html2canvas.hertzen.com/
// https://popmotion.io/
// https://github.com/mattboldt/typed.js/
// http://scrollmagic.io/
