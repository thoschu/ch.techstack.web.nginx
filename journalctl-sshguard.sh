#!/bin/bash

message=DONE!!!
greeting="Greetz by"
name="Tom S."

echo "Enter a duration like 'today', 'yesterday', or 'n days ago' like '7 days ago':"
read duration

regex_pattern="^[0-9]+ days ago$"

if [ "$duration" == "today" ]; then
  :
elif [ "$duration" == "yesterday" ]; then
  :
elif [[ "$duration" =~ $regex_pattern ]]; then
  :
else
  duration="today"
fi

journalctl -u sshguard --since "$duration" --no-pager

echo "$message $greeting $name - $(hostname -I | awk '{print $1}')"
