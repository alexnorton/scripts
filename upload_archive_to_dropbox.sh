#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: upload_archive_to_dropbox.sh [path]"
    exit 1
fi

dropbox_uploader=/Users/alex/Desktop/dropbox_uploader.sh

dropbox_upload_path=/Downloads/

path=$1

temp_dir=./temp

if [[ -d $path ]]; then
  echo "$path is a directory"
  archive_name=$(basename $path).tar
  archive_path=$temp_dir/$archive_name
  tar -cvf $archive_path $path
  $dropbox_uploader upload "$archive_path" "$dropbox_upload_path"
  rm $archive_path
elif [[ -f $path ]]; then
  echo "$path is a file"
  $dropbox_uploader upload "$path" "$dropbox_upload_path"
else
  echo "$path is not valid"
  exit 1
fi


