#!/bin/bash

#ssh without password
cd /root
ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
cp /apache/conf/ssh/ssh_config /root/.ssh/config
chmod 600 /root/.ssh/config && chown root:root /root/.ssh/config
sed  -i "/^[^#]*UsePAM/ s/.*/#&/" /etc/ssh/sshd_config && echo "UsePAM no" >> /etc/ssh/sshd_config && echo "Port 2122" >> /etc/ssh/sshd_config
