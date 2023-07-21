#!/bin/bash

echo "> running as: `id`"

# add pubkey from arg
if [[ $# -gt 0 ]]
then
  for var in "$@"
  do
    echo "> adding a public ssh key from arg"
    echo "$var" >> /home/dev/.ssh/authorized_keys
  done
fi

# add pubkey from env var
if [[ -n "$PUBKEY" ]]
then
  echo "> adding public ssh key from PUBKEY env var"
  echo $PUBKEY >> /home/dev/.ssh/authorized_keys
fi

# generate host keys if they don't exist
/usr/bin/ssh-keygen -A -f /home/dev/.ssh

echo "starting sshd..."
# start the server
/usr/sbin/sshd -D
