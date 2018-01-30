#!/bin/bash

#transfer docker image to production vm
#sftp -oPort=2222 vm-production@127.0.0.1 <<< $'put parcelconfig-size images/'

#transfer js-files to production vm
#sftp -oPort=2222 vm-production@127.0.0.1 <<< $'put web/js/parcel-size.component.js js/'

#load docker image to local docker registry and start container
#ssh -p 2222 vm-production@127.0.0.1 'docker load -i parcelconfig-size | docker run -d -p 1121:1100 parcelconfig-size'

result=$(ssh -p 2222 vm-production@127.0.0.1 'docker ps --filter ancestor=parcelconfig-main --format "{{.Names}}"')

#load js file to webserver
for i in $result
do
	echo $i
	#ssh -p 2222 vm-production@127.0.0.1 'docker cp js/parcel-size.component.js $i:/usr/local/tomcat/webapps/ParcelConfigService/js'
done
