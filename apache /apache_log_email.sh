#!/bin/bash

#get date (for filename)
DATE=`date +%Y%m%d%H%M`

sourcefile=access_log
destfile="loggedIPs-$DATE.txt"

#set loop variables
i=1
loggedIP="blank"

#loop through file
while read line; do

   #break if > 10 lines
   if [ $i -gt 10 ]
   then
      break
   fi

   #extract just the IP address
   newIP=`echo $line | sed 's/ .*//'`

   #check if IP is duplicate of previous line
   if [ $newIP != $loggedIP ]
   then

      #rwrite ip & reverse dns lookup info to file
      echo "IP: $newIP DNS: `host $newIP`" >> $destfile

      #iterator + 1
      i=`expr $i + 1`

      #set loggedIP to read IP for comparison
      loggedIP=$newIP

   fi

done <$sourcefile

#mail file with command something like this
#echo "Last 10 logged IPs" | mail -s "ACCESS LOG" -r "<name@domain.com>" -a "loggedIPs-$DATE.txt"



