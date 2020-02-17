#!/bin/bash
sudo chmod 666 /var/run/docker.sock
././config.sh --url $REPO --token $TOKEN
./run.sh