docker rm -f kafka_config_root
docker rm -f kafka_data_root
docker run --name=kafka_config_root -v /home/docker/config/kafka:/opt/kafka_2.10-0.8.2.1/config -d dockerhub:5000/busybox echo kafka_config_root
docker run --name=kafka_data_root -v /home/kafka/data:/kafka -d dockerhub:5000/busybox echo kafka_data_root
docker run --name=kafka  --volumes-from kafka_config_root --volumes-from kafka_config_root -d -p 9092:9092 dockerhub:5000/kafka
