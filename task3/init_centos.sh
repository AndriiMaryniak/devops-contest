#!/bin/bash
dnf update -y

dnf install nginx -y

systemctl enable nginx

systemctl start nginx

MY_OS_VER=$(source /etc/os-release && echo $PRETTY_NAME)

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head><titel>CentOS Task</title></head>
<body>
	<h1>Hello world!</h1>
	<p>Internal network</p>
	<p>OS Version: $MY_OS_VER</p>
</body>
</html>
EOF
