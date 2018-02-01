#!/bin/bash

#transfer docker image to production vm
sftp -oPort=2223 vm-production@127.0.0.1 <<< $'put parcelconfig-size images/'

#load docker image to local docker registry and start container
ssh -p 2223 vm-production@127.0.0.1 'docker load -i images/parcelconfig-size'

result=$(ssh -p 2222 vm-production@127.0.0.1 'docker ps --filter ancestor=parcelconfig-size --format "{{.Names}}"')
var=1
for i in $result
do
	port=$(expr 1120 + $var)
	ssh -p 2223 vm-production@127.0.0.1 'docker run -d -p $port:1100 parcelconfig-size'
	var=$((var+1))
done	 

#load js file to webserver
sftp -oPort=2223 vm-production@127.0.0.1 <<< $'put web/js/parcel-size.component.js repository/js/'

#change load balance config
sftp -oPort=2223 vm-production@127.0.0.1 <<< $'put haproxy.cfg /etc/haproxy/'
ssh -p 2223 vm-production@127.0.0.1 'sudo /etc/init.d/haproxy reload'
