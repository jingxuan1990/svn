#!/usr/bin/env bash

#################
# Add a new SVN project
#
# Author: Andy Li
# Date: 3/18/2015
#################

project_name="$1"
username="$2"
password="$3"


function usage(){
    echo 'usage:'
    echo '     1. script_name new_project_name'
    echo '     2. script_name new_project_name username password'

}

if [  $# -eq 0 ]; then
   usage
fi

if [ -z "$project_name" ]; then
    echo "The project name mustn't be empty!"
    exit 128
fi

umask 0002

mkdir -p /home/svn/$project_name

#The SVN repository can be created using the following command.
svnadmin create /home/svn/$project_name

# Add a new group name -- subversion
addgroup subversion

# Add www-data to subversion group, we will use www-data to start apache server
usermod -G subversion -a www-data

#And use the following commands to correct file permissions
cd /home/svn
chown -R www-data:subversion $project_name
chmod -R g+rws $project_name

#################
# configure apache2 to access SVN server via https or http
#################
if [ ! -d /etc/apache2/mods-available ]; then
    mkdir -p /etc/apache2/mods-available
fi

cat >>/etc/apache2/mods-available/dav_svn.conf <<HELLO

<Location /svn/$project_name>
   DAV svn
   SVNPath /home/svn/$project_name
   AuthType Basic
   AuthName "$projec_name subversion repository"
      AuthUserFile /etc/subversion/passwd
   Require valid-user
</Location>

HELLO

# configure default user and password for new project

if [ -z "$username" -o -z "$password" ]; then
    username="andy"
    password="lwh123456$"
fi

if [ ! -f /etc/subversion/passwd ]; then
    htpasswd -bc /etc/subversion/passwd $username $password
else
    htpasswd -b /etc/subversion/passwd $username $password
fi

if [ -f /etc/init.d/apache2 -a -x /etc/init.d/apache2 ]; then
    /etc/init.d/apache2 restart
fi

exit 0

