#!/bin/bash
#To be used for the GW update 
#to upload the file to server: 
#curl -F "file=@version_x_upgrade.sh" http://192.168.115.41/SDC/gateway
if [ -f ~/ready_for_upgrade ] ; then
	echo "ready for upgrade!"
	# remove the file during the upgrade
	# then, put it back after the upgrade
	# touch ~/ready_for_upgrade
else
   echo "upgrade on going!"
fi
v=`cat ~/gw.version`
let v+=1
echo $v > ~/gw.version
