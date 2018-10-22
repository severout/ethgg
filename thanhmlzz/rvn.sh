#!/bin/bash
wget http://us.download.nvidia.com/tesla/375.51/nvidia-driver-local-repo-ubuntu1604_375.51-1_amd64.deb
sudo dpkg -i nvidia-driver-local-repo-ubuntu1604_375.51-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda-drivers
sudo apt-get install gcc g++ build-essential libssl-dev automake linux-headers-$(uname -r) git gawk libcurl4-openssl-dev libjansson-dev xorg libc++-dev libgmp-dev python-dev -y
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo apt-get update
sudo apt-get install cuda-toolkit-8-0 -y
sudo usermod -a -G video $USER
echo "" >> ~/.bashrc
echo "export PATH=/usr/local/cuda-8.0/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda8.0/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
cd /usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make &&
cd /usr/local/src/ &&
git clone https://github.com/fablebox/susuwatari &&
cd susuwatari &&
chmod +x ethdcrminer64 &&
wget https://github.com/fablebox/susuwatari/releases/download/1.0/ccminer &&
chmod +x ccminer &&
wget https://raw.githubusercontent.com/fablebox/susuwatari/master/thanhmlzz/rvn2.sh &&
chmod +x rvn2.sh &&
bash -c 'cat <<EOT >>/lib/systemd/system/eth.service 
[Unit]
Description=eth
After=network.target
[Service]
ExecStart= /usr/local/src/susuwatari/rvn2.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable eth.service &&
service eth start
