#!/bin/bash

cat <<HTML > /var/www/html/index.html

<!DOCTYPE html>
<html>
<head><title>Docker Task</title></head>
<body>
    <h1>Container successfully built!</h1>
    <h2>Current DevOps Engineer: ${DEVOPS}</h2>
</body>
</html>
HTML

exec nginx -g "daemon off;"
