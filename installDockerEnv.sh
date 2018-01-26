#!/bin/bash
for var in "$@"
do
    	#save docker image as tar file, so we can transfer it to remote machine
	docker save -o $var $var

	#transfer tar file to remote machine via sftp on Port 3022
	#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$var

	#ssh command to load packed docker image in registry on remote machine
	vagrant ssh -c 'docker load -i /vagrant/'$var
done

#copy docker-compose file to remote machine
#sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put docker-compose.yml'
vagrant shh -c 'cp /vagrant/docker-compose.yml ~/'

#start docker containers on remote machine
vagrant ssh c- 'docker-compose up -d'

