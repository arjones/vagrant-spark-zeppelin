#!/usr/bin/env bash
#
# Copyright 2017 Gustavo Arjones (@arjones)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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

echo "Copying datasets to /opt/dataset"
cp -vR data/* /opt/dataset/

echo "Copying code example to /home/vagrant/samples"
cp -vR code /home/vagrant/samples
