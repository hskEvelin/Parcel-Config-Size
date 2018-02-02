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

for var in "$@"
do
   	#save docker image as tar file, so we can transfer it to remote machine
	docker save -o $var $var

	#transfer tar file to remote machine via sftp on Port 3022
	#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$var

	#ssh command to load packed docker image in registry on remote machine
	vagrant ssh -c 'docker load -i /vagrant/'$var':latest'

done

#copy docker-compose file to remote machine
vagrant ssh -c 'cp /vagrant/docker-compose.yml ~/'

#start docker containers on remote machine
vagrant ssh -c 'docker-compose up -d'

