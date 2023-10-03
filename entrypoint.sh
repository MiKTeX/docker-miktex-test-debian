#!/bin/sh -e

apt-get -y update
apt-get -y dist-upgrade

if [ -d /miktex/build ]; then
    apt -y install /miktex/build/*.deb
else
    curl -fsSL https://miktex.org/download/key | sudo tee /usr/share/keyrings/miktex-keyring.asc > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/miktex-keyring.asc] http://miktex.org/download/debian bookworm universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    apt-get -y install miktex
fi

GROUP_ID=${GROUP_ID:-1001}
USER_ID=${USER_ID:-1001}

groupadd -g $GROUP_ID -o joe
useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m joe
export HOME=/home/joe
exec gosu joe "$@"
