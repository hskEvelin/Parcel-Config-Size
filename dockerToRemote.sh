#!/bin/bash

#save docker image as tar file, so we can transfer it to remote machine
docker save -o $1 $2

#transfer tar file to remote machine via sftp on Port 3022
sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put '$1

#ssh command to load packed docker image in registry on remote machine
ssh -p 3022 vm-uat@127.0.0.1 'docker load -i '$1
