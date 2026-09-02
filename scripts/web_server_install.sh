#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y nginx

echo "<h1>This is Fernando's Cloud Infrastructure ENG take home exercise</h1>\
<p>GO RAVENS</p>" > /var/www/html/index.html

systemctl enable --now nginx
