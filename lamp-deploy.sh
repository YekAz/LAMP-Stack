#!/bin/bash

echo "Initiating LAMP Stack installation and set-up"
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
sudo systemctl restart apache2
echo " "
sleep 2

# Installing MySQL database
echo "Installing MySQL database"
sudo apt install -y mysql-server
sleep 3
echo " "

# Configuring MySQL
echo "Configuring MySQL"
sudo mysql -uroot -e "CREATE DATABASE laravelApp;"
sudo mysql -uroot -e "CREATE USER 'azeez'@'localhost' IDENTIFIED BY 'vagrant';"
sudo mysql -uroot -e "FLUSH PRIVILEGES"
sudo mysql -uroot -e "SHOW DATABASES;"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON laravelApp.* TO 'azeez'@'localhost';"

# Restarting MySQL service
echo "Restarting MySQL service"
sudo systemctl restart mysql

# Install PHP
echo "Installing PHP"
sudo add-apt-repository ppa:ondrej/php --yes
sudo apt update
sudo apt install -y php8.2 php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-mysql zip unzip
echo " "
sleep 2

# Output status message
echo "LAMP stack deployment complete."

# Install composer for laravel
cd /usr/bin
curl -sS https://getcomposer.org/installer | sudo php
sudo mv composer.phar composer

# Clone the laravel app repo inside the /var/www/ and get dependencies
cd /var/www/
sudo git clone https://github.com/laravel/laravel.git
sudo chown -R $USER:$USER /var/www/laravel

# Get dependencies
cd laravel
sudo composer install --optimize-autoloader --no-dev

# Update ENV file and generate an encryption key
sudo cp .env.example .env
sudo php artisan key:generate
sudo php artisan migrate

# cd /var/www/laravel
# # Define the variables you want to replace
# DB_CONNECTION="mysql"
# DB_HOST="localhost"
# DB_DATABASE="laravelApp"
# DB_USERNAME="azeez"
# DB_PASSWORD="vagrant"

# # Uncomment lines if they are commented
# sudo sed -i '/^#DB_HOST=/s/^#//' .env
# sudo sed -i '/^#DB_DATABASE=/s/^#//' .env
# sudo sed -i '/^#DB_USERNAME=/s/^#//' .env
# sudo sed -i '/^#DB_PASSWORD=/s/^#//' .env
# sudo sed -i '/^#DB_PORT=/s/^#//' .env

# # Use sed to replace the values in the .env file
# sudo sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=${DB_CONNECTION}/" .env
# sudo sed -i "s/^DB_HOST=.*/DB_HOST=${DB_HOST}/" .env
# sudo sed -i "s/^DB_DATABASE=.*/DB_DATABASE=${DB_DATABASE}/" .env
# sudo sed -i "s/^DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/" .env
# sudo sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" .env

# Uncomment the DB settings in the .env file
cd /var/www/laravel

sudo sed -i "23 s/^#//g" /var/www/laravel/.env
sudo sed -i "24 s/^#//g" /var/www/laravel/.env
sudo sed -i "25 s/^#//g" /var/www/laravel/.env
sudo sed -i "26 s/^#//g" /var/www/laravel/.env
sudo sed -i "27 s/^#//g" /var/www/laravel/.env

# Enter the values for each DB term in the .env file
sudo sed -i '22 s/=sqlite/=mysql/' /var/www/laravel/.env
sudo sed -i '23 s/=127.0.0.1/=localhost/' /var/www/laravel/.env
sudo sed -i '24 s/=3306/=3306/' /var/www/laravel/.env
sudo sed -i '25 s/=laravel/=laravelApp/' /var/www/laravel/.env
sudo sed -i '26 s/=root/=azeez/' /var/www/laravel/.env
sudo sed -i '27 s/=/=vagrant/' /var/www/laravel/.env

# set permissions
sudo chown -R www-data storage
sudo chown -R www-data bootstrap/cache

# configure apache for laravel
cd /etc/apache2/sites-available/
sudo touch Laravelapp.conf

# Define the Apache configuration content
CONFIG_CONTENT=$(cat <<EOL
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/laravel-error.log
    CustomLog \${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>
EOL
)

# Write the configuration content to the Apache configuration file
echo "$CONFIG_CONTENT" | sudo tee /etc/apache2/sites-available/Laravelapp.conf

# activate apache rewrite module and enable website
sudo a2enmod rewrite
sudo a2dissite 000-default.conf
sudo a2ensite Laravelapp.conf
sudo apache2ctl -t
sudo systemctl restart apache2




