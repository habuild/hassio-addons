#!/usr/bin/with-contenv bashio

cd /

# Sleep until log updated from last SBFspot run
sleep 45

# set tail to log out to HA log
echo '[SBFspot Upload Log Latest]'
tail -n1 /data/sbfspot/log/* >> /proc/1/fd/1
