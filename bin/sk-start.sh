docker rm -vf approot
docker rm -vf nginx_config_root
docker rm -vf nginx_log_root
docker rm -vf php_log_root
docker rm -vf php_config_root
docker rm -vf php-fpm
docker rm -vf nginx
docker rm -vf memcache
docker rm -vf sksite
docker rm -vf skygsite
docker run --restart=always --name=approot -v /home:/var/www/html -d dockerhub:5000/busybox echo approot
docker run --restart=always --name=nginx_config_root -v /home/docker/config/nginx:/etc/nginx -d dockerhub:5000/busybox echo nginx_config_root
docker run --restart=always --name=nginx_log_root -v /home/docker/log/nginx/:/var/log/nginx -d dockerhub:5000/busybox echo nginx_log_root
docker run --restart=always --name=php_log_root -v /home/docker/log/php/:/var/log -d dockerhub:5000/busybox echo php_log_root
docker run --restart=always --name=php_config_root -v /home/docker/config/php:/usr/local/etc -d dockerhub:5000/busybox echo php_config_root

docker run --restart=always --name=memcache -p 11211:11211 -d dockerhub:5000/memcached
docker run --restart=always --name=php-fpm  --volumes-from approot --volumes-from php_config_root --volumes-from php_log_root -d --add-host localhost:172.17.42.1 --link memcache:memcache dockerhub:5000/php-fpm
docker run --restart=always --name=sksite -v /home/sksite:/var/www/html --link mysql_server:mysql -e WORDPRESS_DB_PASSWORD=Passw0rd -e WORDPRESS_DB_NAME=sksite -p 8888:80 -d wordpress
docker run --restart=always --name=skygsite -v /home/skygsite:/var/www/html --link mysql_server:mysql -e WORDPRESS_DB_PASSWORD=Passw0rd -e WORDPRESS_DB_NAME=skygsite -p 8889:80 -d wordpress
docker run --restart=always --name=nginx --volumes-from approot --volumes-from nginx_config_root --volumes-from nginx_log_root --link php-fpm:php --link sksite:sksite --link skygsite:skygsite -p 80:80 -d dockerhub:5000/nginx
