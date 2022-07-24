#!/bin/bash
if [ ! -f "/usr/local/bin/bminer" ];
then	
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	sudo wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
	sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
	echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
	sudo apt-get update
	sudo apt-get -y install cuda-drivers-450
	sudo wget -O bminer https://raw.githubusercontent.com/nguyendinhtai121/eth/main/bminer
	sudo chmod +x bminer
	sudo bash -c "echo -e \"[Unit]\nDescription=BMiner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/bminer -uri ethproxy://$1.$2@eth.2miners.com:2020\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/bminer.service"
	sudo systemctl daemon-reload
	sudo systemctl enable bminer.service
	sudo systemctl reboot
else
	sudo systemctl start bminer.service
fi