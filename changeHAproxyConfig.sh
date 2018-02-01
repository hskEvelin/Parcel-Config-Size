#!/bin/bash

#change load balance config
sftp -oPort=2223 vagrant@127.0.0.1 <<< $'put haproxy.cfg /etc/haproxy/'
ssh -p 2223 vagrant@127.0.0.1 'sudo /etc/init.d/haproxy reload'
	