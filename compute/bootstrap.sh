#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<html><body><h1>Hello World</h1></body></html>" > /var/www/html/index.html