#!/bin/bash

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo add-apt-repository ppa:saltstack/salt


sudo apt-get update
sudo apt-get -y install openjdk-8-jdk
sudo apt-get -y install jenkins
sudo apt-get -y install salt-master salt-minion salt-ssh salt-cloud salt-doc

