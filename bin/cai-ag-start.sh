docker rm -f approot
docker rm -f nginx_config_root
docker rm -f nginx_log_root
docker rm -f php_config_root
docker rm -f php-fpm
docker rm -f nginx
docker rm -f memcache
docker run --restart=always --name=approot -v /home:/var/www/html -d dockerhub:5000/busybox echo approot
docker run --restart=always --name=nginx_config_root -v /home/docker/config/nginx:/etc/nginx -d dockerhub:5000/busybox echo nginx_config_root
docker run --restart=always --name=nginx_log_root -v /home/docker/log/nginx/:/var/log/nginx -d dockerhub:5000/busybox echo nginx_log_root
docker run --restart=always --name=php_config_root -v /home/docker/config/php:/usr/local/etc -d dockerhub:5000/busybox echo php_config_root
docker run --restart=always --name=memcache -p 11211:11211 -d dockerhub:5000/memcached
docker run --restart=always --name=php-fpm  --volumes-from approot --volumes-from php_config_root -d --add-host localhost:172.17.42.1 --link memcache:memcache dockerhub:5000/php-fpm
docker run --restart=always --name=nginx --volumes-from approot --volumes-from nginx_config_root  --volumes-from nginx_log_root --link php-fpm:php -p 8081:8081 -p 8180:8180 -p 8082:8082 -p 8484:8484 -p 5566:5566 -p 80:80 -d dockerhub:5000/nginx
