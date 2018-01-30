#!/bin/bash

#start docker environment on remote machine
ssh -p 3022 vm-uat@127.0.0.1 'docker-compose up -d'
