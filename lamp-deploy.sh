#!/bin/bash

echo "Initiating LAMP Stack installation and set-up"
echo " "

echo "------------------>"
sleep 1
echo "------------------>"
sleep 1
echo "------------------>"
sleep 1
echo " "

# Update package index
echo "Updating repository package index"
sudo apt update
echo "Update Successful"
echo " "
sleep 2

# Install Apache
echo "Installing Apache web server"
sudo apt install -y apache2
echo " "
sleep 2

# Install MySQL
echo "Installing MySQL database"
sudo apt install -y mysql-server
echo " "
sleep 2

# Install PHP
echo "Installing PHP"
sudo apt install -y php libapache2-mod-php php-mysql php-curl php-gd php-json php-mbstring php-xml php-zip
echo " "
sleep 2

# Output status message
echo "LAMP stack deployment complete."

