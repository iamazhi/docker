docker rm -f approot
docker rm -f nginx_config_root
docker rm -f nginx_log_root
docker rm -f php_config_root
docker rm -f php-fpm
docker rm -f nginx
docker run --name=approot -v /home:/var/www/html -d dockerhub:5000/busybox echo approot
docker run --name=nginx_config_root -v /home/docker/config/nginx/conf.d:/etc/nginx/conf.d -d dockerhub:5000/busybox echo nginx_config_root
docker run --name=nginx_log_root -v /home/docker/log/nginx/:/var/log/nginx -d dockerhub:5000/busybox echo nginx_log_root
docker run --name=php_config_root -v /home/docker/config/php:/usr/local/etc/php -d dockerhub:5000/busybox echo php_config_root
docker run --name=php-fpm  --volumes-from approot --volumes-from php_config_root -d --add-host localhost:172.17.42.1 dockerhub:5000/php-fpm
docker run --name=nginx --volumes-from approot --volumes-from nginx_config_root  --volumes-from nginx_log_root --link php-fpm:php -p 8081:8081 -p 8082:8082 -p 80:80 -d dockerhub:5000/nginx
