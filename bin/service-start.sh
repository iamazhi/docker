#! /bin/bash
docker rm -f tomcat-org
docker run --restart=always --name=tomcat-org -v /home/java/webapps/organization-service:/home/tomcat/webapps/demo -v /home/java/src/organization-service:/home/tomcat/src/demo -p 8890:8080 -ti -d dockerhub:5000/java ./home/tomcat/src/demo/docker.sh prod
docker rm -f tomcat-avatar
docker run --name=tomcat-avatar -v /home/java/webapps/cash-avatar:/home/tomcat/webapps/demo  -v /home/java/src/csh-avatar:/home/tomcat/src/demo -p 8686:8080 -ti -d dockerhub:5000/java ./home/tomcat/src/demo/docker.sh prod
docker rm -f token-service
docker run --restart=always --name=token-service -ti -v /home/golang/token-service:/home/goProjects -v /home/golang/gopath:/go -v /etc/localtime:/etc/localtime -w /home/goProjects/src/token-service -p 8777:8777  -d dockerhub:5000/golang ./ok.sh
docker rm -f cgj_ui_server
docker run --restart=always -p 4000:4000 -it --name=cgj_ui_server -v /home/nodejs/cgj_ui_server:/home/cgj_ui_server -w /home/cgj_ui_server -d  dockerhub:5000/node nohup node bin/www
docker rm -f advanced_org_service
docker run --restart=always -p 6000:6000 -it --name=advanced_org_service -v /home/nodejs/advanced_org_service:/home/advanced_org_service -w /home/advanced_org_service  -d dockerhub:5000/node nohup node main.js &
docker rm -f cgj_jurisdiction
docker run --restart=always -p 6100:6100 -it --name=cgj_jurisdiction -v /home/nodejs/cgj_jurisdiction:/home/cgj_jurisdiction -w /home/cgj_jurisdiction  -d dockerhub:5000/node nohup node bin/www &
docker rm -f tomcat-jur-ui
docker run --restart=always --name=tomcat-jur-ui -v /home/java/webapps/cgj_jurisdiction_ui:/home/tomcat/webapps/demo -v /home/java/src/cgj_jurisdiction_ui:/home/tomcat/src/demo -p 8988:8080  -ti -d dockerhub:5000/java ./home/tomcat/src/demo/docker.sh prod
docker rm -f tomcat-org-ui
docker run --restart=always --name=tomcat-org-ui -v /home/java/webapps/org-ui:/home/tomcat/webapps/demo -v /home/java/src/org-ui:/home/tomcat/src/demo -p 8989:8080 --add-host="localhost:172.17.42.1"  -ti -d dockerhub:5000/java ./home/tomcat/src/demo/docker.sh prod
docker rm -f omnirest
docker run --restart=always --name=omnirest -v /home/java/webapps/omnirest:/home/tomcat/webapps/ROOT -v /home/java/src/omnirest:/home/tomcat/src/demo -p 7070:8080 -ti -d   dockerhub:5000/tomcat_6 ./home/tomcat/src/demo/docker.sh csh/prod
docker rm -f csh_new_job
docker run --restart=always --name=csh_new_job -v /home/java/logs/csh_new_job:/home/tomcat/logs -v /home/java/src/csh_new_job:/home/tomcat/src/demo  -p 8850:8080 -ti -d dockerhub:5000/java ./home/tomcat/src/demo/run.sh prod
