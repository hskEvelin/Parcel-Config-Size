#!/bin/bash
#create VM and start it
vagrant up --provider=virtualbox

#while [ $# -gt 0 ]
#do
#	img = $1
	#save docker image as tar file, so we can transfer it to remote machine
#	docker save -o $img $img

	#transfer tar file to remote machine via sftp on Port 3022
	#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$var

	#ssh command to load packed docker image in registry on remote machine
#	vagrant ssh -c 'docker load -i /vagrant/'$img

#	shift
	#start docker containers
#	vagrant ssh -c 'docker run -d -p 1100:1100 '$img
#done

#create docker network
vagrant ssh -c 'docker network create parcelconfig-net'

for var in "$@"
do
   	#save docker image as tar file, so we can transfer it to remote machine
	docker save -o $var $var

	#transfer tar file to remote machine via sftp on Port 3022
	#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$var
	sshcmd='docker load -i /vagrant/'$var
	#ssh command to load packed docker image in registry on remote machine
	vagrant ssh -c $sshcmd

done

#install mysql docker container and run it
docker save -o parcel-mysql mysql/mysql-server:5.7.21
vagrant ssh -c 'docker load -i /vagrant/parcel-mysql'
vagrant ssh -c 'docker run --name=mysql --mount type=bind,src=/vagrant/scripts/,dst=/docker-entrypoint-initdb.d/ --net parcelconfig-net -e=MYSQL_ROOT_PASSWORD="mysql" -d mysql/mysql-server:5.7.21'

#copy docker-compose file to remote machine
vagrant ssh -c 'cp /vagrant/docker-compose.yml ~/'

#start docker containers on remote machine
#vagrant ssh -c 'docker-compose up -d'
vagrant ssh -c 'docker run --name=webserver --net parcelconfig-net -p 1150:8080 -d parcelconfig-main:latest'
vagrant ssh -c 'docker run --name=parcelconfig-size --net parcelconfig-net -p 1100:1100 -d parcelconfig-size:latest'
