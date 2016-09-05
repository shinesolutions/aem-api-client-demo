#!/bin/bash

sudo yum install -y git ruby-devel gcc
git clone https://github.com/cliffano/aem-api-client-demo
sudo sh -c 'echo "cd /home/ec2-user/aem-api-client-demo/slackbot/ && nohup make start &" >> /etc/rc.local'
