#!/usr/bin/with-contenv bashio

#---- old method
# set tail to log out to HA log
# Use lognow variable to select latest file
# echo '[SBFspot Upload Log Latest]'
# tail -n1 /data/sbfspot/log/SBFspotUpload$lognow.log >> /proc/1/fd/1


cd /

#---- Create lognow variable
lognow=$(date +%Y%m%d)

# Sleep until log updated from last SBFspot run
sleep 45

#---- set tail to log out to HA log
#---- Use lognow variable to select latest file
#---- Print tail of latest log

message=$(echo "[SBFspot Upload Log Latest] $(tail -n1 /data/sbfspot/log/SBFspotUpload$lognow.log)")

## Print the message the user supplied, defaults to "Hello World..."
bashio::log.info "${message:="Hello World..."}"


#---- Delete old log files 
#busybox command for minus 1 day
#date +%Y%m%d -d @$(($(date +%s)-86400))

# remove log files older than 3 days
find /data/sbfspot/log -mtime +3 -exec rm {} \;

