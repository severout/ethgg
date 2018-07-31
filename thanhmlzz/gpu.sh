#!/bin/bash
apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
wget https://github.com/nanopool/ewbf-miner/releases/download/v0.3.4b/Zec.miner.0.3.4b.Linux.Bin.tar.gz &&
tar -zxvf Zec.miner.0.3.4b.Linux.Bin.tar.gz &&
wget https://raw.githubusercontent.com/fablebox/susuwatari/master/thanhmlzz/gpu2.sh &&
chmod +x gpu2.sh &&
bash -c 'cat <<EOT >>/lib/systemd/system/gpu.service 
[Unit]
Description=gpu
After=network.target
[Service]
ExecStart= /usr/local/src/gpu2.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable gpu.service &&
service gpu start
