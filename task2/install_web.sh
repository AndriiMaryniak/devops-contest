#!/bin/bash
apt -update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
source /etc/os-release
echo "<h1>Hello World</h1><p>OS Version: $PRETTY_NAME</p>" > /var/www/html/index.html
