#!/bin/bash

echo '------------------------------------'
echo "cat /home/`whoami`/shared/docker.txt"
cat /home/`whoami`/shared/docker.txt

echo '-----------------------------------'
echo "cat /home/`whoami`/shared/ports.txt"
cat /home/`whoami`/shared/ports.txt

echo
echo 'Press Enter to continue.'
read -p '************************' continue

/usr/local/bin/check | more
