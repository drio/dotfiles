#!/bin/bash
#

DST=$1
if [ ".$DST" == "." ];then
  echo "provide ssh url please"
  exit 0
fi

rsync -e ssh --progress -avz ../../dotfiles  \
  --delete \
  --exclude=.config/secrets \
  --exclude=.config/packer \
  --exclude=".git" \
  --exclude="obs/sounds" \
  --exclude=".hammerspoon/emojis" \
  $DST:.

cat README.next.txt
