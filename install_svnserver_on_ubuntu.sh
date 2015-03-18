#!/usr/bin/env bash

#################
# Install SVN Server on Ubuntu
#
# Author: Andy Li
# Date: 3/18/2015
#################

apt-get update
apt-get install apache2
apt-get install apache2-utils
apt-get install subversion
apt-get install libapache2-svn
