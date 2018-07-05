serveruptime=`uptime | awk '{print $3,$4}'| sed 's/,//'| grep "day"`;
if [[ -z "$serveruptime" ]]; then 
	serveruptime=`uptime | awk '{print $3}'| sed 's/,//'`; 
	echo $serveruptime
else 
	:; 
fi;