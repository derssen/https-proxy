#!/bin/bash

echo "=================================================="
if [ ! $domain ]; then
        read -p "Enter link to domain name: " domain
        echo 'export domain='${domain} >> $HOME/.bash_profile
fi
curl $domain
echo "Domain name configured"

echo "=================================================="
curl -Lo /usr/local/bin/dumbproxy 'https://github.com/Snawoot/dumbproxy/releases/download/v1.6.1/dumbproxy.linux-amd64' && chmod +x /usr/local/bin/dumbproxy
echo "App downloaded"

echo "=================================================="
dumbproxy -passwd /etc/dumbproxy.htpasswd necobra Sanya#777!
echo 'OPTIONS=-auth basicfile://?path=/etc/dumbproxy.htpasswd -autocert -bind-address :443' >> /etc/default/dumbproxy
echo "App configured"

echo "=================================================="
echo "[Unit]
Description=Dumb Proxy
Documentation=https://github.com/Snawoot/dumbproxy/
After=network.target network-online.target
Requires=network-online.target

[Service]
EnvironmentFile=/etc/default/dumbproxy
User=root
Group=root
ExecStart=/usr/local/bin/dumbproxy $OPTIONS
TimeoutStopSec=5s
PrivateTmp=true
ProtectSystem=full
LimitNOFILE=20000

[Install]
WantedBy=default.target
" > /etc/systemd/system/dumbproxy.service


systemctl daemon-reload
systemctl enable dumbproxy
systemctl start dumbproxy

echo "Service created and started"
echo "=================================================="
