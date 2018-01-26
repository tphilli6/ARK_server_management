#!/bin/bash


#Initialize variables and commands
sendemail=false   #if Ip address changes then an email will be sent

getip="`curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`"

#Kernel
if [ ! -f ".external_ip" ]; then
  echo ${getip} > .external_ip
  sendemail=true
else

  old_ip=`cat .external_ip`
  new_ip=${getip}

  if ! [ $old_ip = $new_ip ]; then
    echo "IP address has changed to " $new_ip
    echo ${getip} > .external_ip
    sendemail=true
  fi

fi

if [ "$sendemail" = true ]; then
  printf "Subject: Ark CandyMountainKidneyExchange Server IP update\nNew IP Address is $new_ip" | msmtp tphilli6@gmail.com
fi
