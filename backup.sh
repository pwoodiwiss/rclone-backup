#!/usr/bin/env bash

config_file=/etc/backup.conf

while read origin destination options
do
   if [[ "$origin" == "-" ]]; then
      origin=$config_file
   elif [[ -d $origin ]]; then
      destination=$destination/$(basename $origin)
   elif [[ ! -f $origin ]]; then
      echo "origin $origin is not a file or directory" 
   fi

   echo "$origin --> $destination (with options: $options)"

   rclone sync $origin $destination --stats-one-line -v --backup-dir=$destination-old
done < $config_file
