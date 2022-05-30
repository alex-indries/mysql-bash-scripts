!#/bin/bash
#Variables
MYSQLSERVICE=`systemctl is-active mysql`

echo "#######################################"
echo "Checking for updates..."
sudo apt-get update
echo "#######################################"
echo "Install mysql-server"
sudo apt-get install mysql-server -y
echo "#######################################"
echo "Mysql service is: $MYSQLSERVICE"
echo "#######################################"
echo "#######################################"

if [ $(echo "SELECT COUNT(*) FROM mysql.user WHERE user = 'admin'" | mysql | tail -n1) -gt 0 ]
then
echo "User exists"

else
echo "Creating new user"
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';"
fi
mysql -e "SELECT User, Host FROM mysql.user;"

echo "Importing the database from the SQL DUMP FILE"

sudo mysql < verticalDB.sql
echo "#######################################"
mysql -e "show databases;"

sudo apt-get install awscli -y


