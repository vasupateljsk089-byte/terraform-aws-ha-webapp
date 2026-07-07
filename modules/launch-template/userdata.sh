#!/bin/bash

HOSTNAME=$(hostname -f)

cat > /var/www/webapp/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Project 2</title>
</head>
<body>
    <h1>Application is Running</h1>
    <h2>Hostname: ${HOSTNAME}</h2>
</body>
</html>
EOF

systemctl restart nginx