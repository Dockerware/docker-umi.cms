#!/usr/bin/env sh

set -e

IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
UMI_IP="${UMI_IP:-"${IP}"}"
UMI_DOMAIN="${UMI_DOMAIN:-"localhost"}"
UMI_TEMPLATE="${UMI_TEMPLATE:-"_blank"}"

cat > install.ini <<- EOF
[SERVER]
phppath=$(which php)

[LICENSE]
key = "${UMI_KEY}"
domain = "${UMI_DOMAIN}"
ip = "${UMI_IP}"

[BACKUP]
mode = "none"

[DB]
host = "${UMI_DB_HOSTNAME}"
user = "${UMI_DB_USERNAME}"
password = "${UMI_DB_PASSWORD}"
dbname = "${UMI_DB_NAME}"
port = "${UMI_DB_PORT}"

[SUPERVISOR]
login = "umi"
password = "umi"
lname = "umi"
fname = "umi"
mname = "umi"
email = "umi@umi.local"

[DEMOSITE]
name = "${UMI_TEMPLATE}"

[SETUP]
sleep=10
download_by=25600
EOF

if [ ! -f "installer.php" ]; then
  echo "Download Installer..."
  curl -L http://updates.umi-cms.ru/updateserver \
   -d type=get-installer \
   -d ip=${UMI_IP} \
   -d host=${UMI_DOMAIN} \
   -d key=${UMI_KEY} \
   -d revision=last \
   -o installer.php
fi

echo "Install..."
php -f installer.php > init.log
echo "DONE"
