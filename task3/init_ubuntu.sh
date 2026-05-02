#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx

cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head><title>Terraform Task</title></head>
<body>
    <h1>Hello World!</h1>
    <p>OS Version: \$(source /etc/os-release && echo \$PRETTY_NAME)</p>
</body>
</html>
HTML
