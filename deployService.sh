#!/bin/bash

#transfer docker image to production vm
sftp -oPort=2222 vm-production@127.0.0.1 <<< $'put parcelconfig-size images/'

#load docker image to local docker registry and start container
ssh -p 2222 vm-production@127.0.0.1 'docker load -i parcelconfig-size | docker run -d -p 1121:1100 parcelconfig-size'

#load js file to webserver
sftp -oPort=2222 vm-production@127.0.0.1 <<< $'put web/js/parcel-size.component.js repository/js/'

#change load balance config
sftp -oPort=2222 vm-production@127.0.0.1 <<< $'put haproxy.cfg /etc/haproxy/'
ssh -p 2222 vm-production@127.0.0.1 'sudo /etc/init.d/haproxy reload'