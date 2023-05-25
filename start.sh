#!/bin/bash

echo "> running as: `id`"

# add pubkey from arg
if [[ $# -gt 0 ]]
then
  echo "> adding public ssh key from arg"
  echo $1 >> /home/dev/.ssh/authorized_keys
fi

# add pubkey from env var
if [[ -n "$PUBKEY" ]]
then
  echo "> adding public ssh key from PUBKEY env var"
  echo $PUBKEY >> /home/dev/.ssh/authorized_keys
fi

# generate host keys if they don't exist
/usr/bin/ssh-keygen -A

echo "starting sshd..."
# start the server
/usr/sbin/sshd -D