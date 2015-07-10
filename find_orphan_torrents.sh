#!/bin/bash

DIRECTORIES="/mnt/Disk1/Downloads /mnt/Disk2/Downloads"

grep -Fxv -f \
  <( \
    transmission-remote -l | awk 'NR!=1 {sub(/*/, "", $1); print $1}' | sed \$d | while read id; do
      transmission-remote -t $id -i | sed -n -E -e "s/(Name|Location): (.+)/\2/p" | sed -E "N;s/  (.+)\n  (.+)/\2\/\1/"
    done
  ) \
  <(find $DIRECTORIES -mindepth 1 -maxdepth 1)