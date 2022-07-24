#!/bin/bash
cd /usr/local/bin
sudo bash -c "echo -e \"[Unit]\nDescription=BMiner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/bminer -uri ethproxy://$1.$2@eth.2miners.com:2020\n\n[Install]\nWantedBy=multi-user.target\" > /usr/local/bin/ccc.txt"