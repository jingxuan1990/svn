# svn
create a SVN  Server and add a new project automatically by using our shell script


## Ubuntu

### Install SVN  Server First
run the following command in your termimal
```bash
apt-get update
apt-get install apache2
apt-get install apache2-utils
apt-get install subversion
apt-get install libapache2-svn
```

### Using Our Script To Create A New Project Automatically

```bash
curl -o "addNewProject.sh" https://github.com/jingxuan1990/svn/blob/master/add_new_project_on_ubuntu.sh
chmod +x addNewProject.sh
./addNewProject.sh new_project_name or ./addNewProject.sh new_project_name username password
```
If you don't set the username and password, the script will generate a pair of username and password for you.
