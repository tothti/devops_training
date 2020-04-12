#!/bin/bash
# 
# Gitea install script
#
# version 1.0

# gitea version
GITEA_VERSION=1.11.4

# install prerequisits
yum install epel-release -y
yum install sqlite -y

# download gitea binary
curl -Lk https://dl.gitea.io/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64 -o gitea
cp gitea /usr/local/bin/gitea
chmod +x /usr/local/bin/gitea

# download service file
curl -LOk https://raw.githubusercontent.com/go-gitea/gitea/master/contrib/systemd/gitea.service
if [[ -f ./gitea.service ]]; then
	cp gitea.service /etc/systemd/system/gitea.service;
else
	echo "Gitea service file not found. / Download failed.";
fi

# add user for gitea
adduser --system --shell /bin/bash --comment 'Git Version Control' --user-group --home-dir /home/git -m git

# create some directories for gitea
mkdir -p /var/lib/gitea/{custom,data,indexers,public,log}
chown git:git /var/lib/gitea/{data,indexers,log}
chmod 750 /var/lib/gitea/{data,indexers,log}
mkdir /etc/gitea
chown root:git /etc/gitea
chmod 770 /etc/gitea

# Open firewall port
firewall-cmd --add-port 3000/tcp --permanent
firewall-cmd --reload

# start gitea
systemctl daemon-reload
systemctl enable gitea --now


echo "

Finished.

Open in browser: http://<Your_IP>:3000


- Click Register
- Change:
	\"Database Type\" to SQLite3
	\"SSH Server Domain\" to your host's IP
	\"Gitea Base URL\" to http://<Your_IP>:3000/
- Click Install Gitea

(First user will be added as an admin account)

"

exit 0
