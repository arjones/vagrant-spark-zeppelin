#!/usr/bin/env bash

echo "Updating System"
apt-get update
apt-get install -y vim net-tools


cat > /home/vagrant/.bash_aliases <<EOF
alias l1='ls -1 --color'
alias ll='ls -la --color'
alias lh='ls -lah --color'
alias grep='egrep --color'
EOF

. /home/vagrant/.bash_aliases
