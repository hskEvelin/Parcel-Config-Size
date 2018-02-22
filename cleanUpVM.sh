#!/bin/bash

vagrant ssh -c 'docker stop mysql-pc-size'
vagrant ssh -c 'docker stop parcelconfig-main'
vagrant ssh -c 'docker stop parcelconfig-size'

vagrant ssh -c 'docker rm mysql-pc-size'
vagrant ssh -c 'docker rm parcelconfig-main'
vagrant ssh -c 'docker rm parcelconfig-size'

vagrant halt 

#stopping all containers, removing them and removing all images
#ssh -p 3022 vm-uat@127.0.0.1 'docker-compose stop -d | docker rm $(docker ps -a -q) | docker rmi $(docker images -q)'

#deleting all transfered files
#ssh -p 3302 vm-uat@127.0.0.1 'rm parcelconfig-main parcelconfig-size parcel-size.component.js docker-compose.yml'