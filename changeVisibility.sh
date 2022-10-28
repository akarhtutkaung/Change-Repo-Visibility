#!/bin/bash

if (($# < 2))
then
  echo "Time in 24hr format (HH:MM:SS): "
  read specifiedTime
  while [[ ! $specifiedTime =~ ^[0-9:]{8} ]]; do
    echo "[!] Enter Number (HH:MM:SS):"
    read specifiedTime
  done
  echo "RepoName with organization if applicable (example: organization/repoName): "
  read repoName
else
  specifiedTime=$1
  while [[ ! $specifiedTime =~ ^[0-9:]{8} ]]; do
    echo "[!] Invalid Time format."
    echo "[!] Exiting..."
    exit 1
  done
  repoName=$2
fi

endtime=$(date -d $specifiedTime '+%H%M%S');

echo "[!] Starting timer to change visibility to public on repo: $repoName"

while [ : ]; do
  currenttime=$(date +%H%M%S);
  echo $specifiedTime
  comparison=$(($endtime-$currenttime))
  if [ $comparison -eq 0 ]
  then
    gh repo edit $repoName --visibility public
    exit 1    
  fi
done