#!/bin/bash
apt-get update
apt-get install -y nginx
echo "<h1>This is Fernando's Cloud Infrastructure ENG take home exercise - GO RAVENS</h1>" >
/var/www/html/index.html
systemctl enable --now nginx
