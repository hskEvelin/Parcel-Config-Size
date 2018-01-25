#!/bin/bash
sleep 10s
#copy .js file to remote machine
sftp -oPort=3022 vm-uat@127.0.0.1 <<< $'put web/js/'$1

#copy .js file into docker container of webserver
ssh -p 3022 vm-uat@127.0.0.1 'docker cp parcel-size.component.js vmuat_webserver_1:/usr/local/tomcat/webapps/ParcelConfigService/js'

	