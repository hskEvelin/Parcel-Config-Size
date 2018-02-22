#!/bin/bash

vagrant ssh -c 'docker run --name=mysql-pc-size --mount type=bind,src=/vagrant/scripts/,dst=/docker-entrypoint-initdb.d/ --net parcelconfig-net -e=MYSQL_ROOT_PASSWORD="mysql" -d mysql/mysql-server:5.7.21'

#wait some time for mysql database to start
sleep 5s

#start docker containers on remote machine
#vagrant ssh -c 'docker-compose up -d'
vagrant ssh -c 'docker run --name=webserver --net parcelconfig-net -p 1150:8080 -d parcelconfig-main'
vagrant ssh -c 'docker run --name=parcelconfig-size --net parcelconfig-net -p 1100:1100 -d parcelconfig-size'