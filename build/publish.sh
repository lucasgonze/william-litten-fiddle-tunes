#!/bin/bash

##################
# Script to push the latest build to a public server
# 
# Assumes ssh passwordless authentication 
##################

REMOTE_DIR=/home/dh_r22cg3/williamlitten.gonze.com
REMOTE_USER=dh_r22cg3
REMOTE_HOST=williamlitten.gonze.com

# path to the stuff we want to copy is relative to this script, 
# so don't move the script.
BASE=`dirname "$0"`/..
LOCAL_SRC="$BASE/jekyll-site/_site/"

if [ ! -d "$LOCAL_SRC" ]
then
    echo "Error: no such directory as $LOCAL_SRC"
fi

set -xv
rsync --verbose --recursive --delete "$LOCAL_SRC" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

