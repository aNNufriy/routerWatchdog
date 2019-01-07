#!/bin/bash
# 
# Author:: Alexander Schedrov (schedrow@gmail.com)
# Copyright:: Copyright (c) 2019 Alexander Schedrov
# License:: MIT

source routerWatchdog.parameters

basicAuth=$(echo -n "$username:$password" | base64)

while true; do
    ping -c 1 8.8.8.8 &>/dev/null
    dns1available=$?
    ping -c 1 8.8.4.4 &>/dev/null
    dns2available=$?

    if [ $dns1available -eq 0 ] && [ $dns2available -eq 0 ]; then
      multiplier=1
      echo "`date` - Ok"
    else
      curl "http://$routerIp/apply.cgi" \
        --header "Authorization: Basic $basicAuth" \
        --data "action_mode=reboot" &>/dev/null
      echo "`date` - Connection problem Router restarted." | tee -a $logFile
      if [ $multiplier -lt 10 ]; then
        multiplier=`expr $multiplier + 1`
      fi
    fi

    sleepTimeout=$(expr $sleepTimeoutBase \* $multiplier)

    sleep $sleepTimeout
done
