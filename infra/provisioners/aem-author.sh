#!/bin/bash

wget --no-cookies --header "Cookie: gpw_e24=xxx; oraclelicense=accept-securebackup-cookie;" "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm"
sudo rpm -i jdk-8u101-linux-x64.rpm
sudo yum install -y git
git clone https://github.com/cliffano/aem-workspace
sudo sh -c 'echo "cd /home/ec2-user/aem-workspace/6.1/ && nohup make start &" >> /etc/rc.local'
