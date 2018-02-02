#!/bin/bash

#tag image with version number
docker tag $(docker images --filter=reference=parcelconfig-size:latest --format "{{.ID}}") parcelconfig-size:$1
docker save -o parcelconfig-size parcelconfig-size:$1

#transfer docker image to production vm
sftp -oPort=2223 vagrant@127.0.0.1 <<< $'put parcelconfig-size images/'

#add version number to old images
#result=$(ssh -p 2223 vagrant@127.0.0.1 'docker ps --filter ancestor=parcelconfig-size --format "{{.ID}}:{{.Names}}"')
#for j in $result
#do
#	echo $j
#	arrImg=(${j//:/ })
#	ssh -p 2223 vagrant@127.0.0.1 'docker tag $arrImg[0] arrImg[1]:$1'
#done

#load docker image to local docker registry and start container
ssh -p 2223 vagrant@127.0.0.1 'docker load -i images/parcelconfig-size'

old_tag=$(($1-1))
result=$(ssh -p 2223 vagrant@127.0.0.1 'docker ps --filter ancestor=parcelconfig-size:old_tag --format "{{.Names}}"')
var=1
for i in $result
do
	port=$(expr 1120 + $var)
	ssh -p 2223 vagrant@127.0.0.1 'docker run -d -p $port:1100 parcelconfig-size:'$1
	var=$((var+1))
done	 

#load js file to webserver
sftp -oPort=2200 vagrant@127.0.0.1 <<< $'put web/js/parcel-size.component.js repository/js/'


