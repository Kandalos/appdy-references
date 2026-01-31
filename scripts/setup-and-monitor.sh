#!/bin/bash

# =================================================================
# AppDynamics Script
# Purpose: Prepares Ubuntu for AppD 
# Components: OS Prep, Networking, and Process Watchdog
# =================================================================

# 1. OS PREPARATION
echo "Checking OS Dependencies..."
sudo apt update && sudo apt install -y libaio1 libncurses5 tar unzip curl

# Missing packages
if [ ! -f /usr/lib/x86_64-linux-gnu/libaio.so.1 ]; then
    echo "Fixing libaio symlink..."
    sudo ln -s /lib/x86_64-linux-gnu/libaio.so.1 /usr/lib/x86_64-linux-gnu/libaio.so.1
fi

# 2. FIREWALL 
echo "Configuring Firewall..."
sudo ufw allow 7001/tcp # EUM HTTP
sudo ufw allow 8090/tcp # Controller Comm
sudo ufw allow 9080/tcp # Events Service
sudo ufw reload

echo "Setup Prepreation Complete."
