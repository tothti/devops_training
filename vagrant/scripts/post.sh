#!/bin/bash

mv /tmp/services/* /etc/systemd/system/
systemctl start node_exporter
