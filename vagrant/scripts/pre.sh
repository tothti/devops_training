#!/bin/bash

echo "Installing Node..."
apt-get install nodejs npm -y
echo "Creating Node Exporter user..."
useradd --no-create-home --shell /bin/false node_exporter
echo "Downloading and installing Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
tar -xvf node_exporter-0.17.0.linux-amd64.tar.gz
mv node_exporter-0.17.0.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-0.17.0.linux-amd64/
rm *
