#!/bin/bash
# Enter the Service name here
service=httpd
# Enter the Directory of httpd log

HOST=`hostname`
date +%d-%m-%y/%H:%M:%S

#Control will enter here if Directory exists.
if (( $(systemctl status $service | grep dead | wc -l) > 0 ))
then
#Control will enter here if the service is down
systemctl restart $service
echo "$service is getting restarted!!!"
#Pause for  10 Sec
echo "Sleeping for 10 seconds"
sleep 10

if (( $(systemctl status $service | grep dead | wc -l) > 0 ))
then
echo "Unable to fix $service service on $HOST- Need Action"
mailx -s "Unable to fix $service service on $HOST- Need Action" -r Maestro_CO@skillsoft.com Maestro_CO@skillsoft.com < /dev/null
else
echo "$service service has been fixed on $HOST- No Action"
mailx -s "$service service has been fixed on $HOST- No Action" -r Maestro_CO@skillsoft.com Maestro_CO@skillsoft.com < /dev/null

fi
else
echo "$service is running!!!"
fi
