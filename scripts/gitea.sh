#!/bin/sh --
set -e

echo "Beginning www/gitea installation..."
# If you prefer to use FreeBSD's official packaging:
sudo env ASSUME_ALWAYS_YES=yes pkg install -y www/gitea
sudo sysrc gitea_enable=YES
sudo sed -i.orig -Ee 's/HTTP_ADDR([\ ]+)=([\ ]+)127.0.0.1/HTTP_ADDR    = 0.0.0.0/g' /usr/local/etc/gitea/conf/app.ini

# Or if you wanted to build gitea by hand:
#go get -d -u code.gitea.io/gitea
#cd $HOME/go/src/code.gitea.io/gitea
#git checkout v1.1.0
#sudo env ASSUME_ALWAYS_YES=yes pkg install -y gmake
#export PATH=$HOME/go/bin:$PATH
#TAGS="bindata sqlite" gmake generate build install
echo "www/gitea installation complete."
