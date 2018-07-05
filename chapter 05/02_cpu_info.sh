for cpus in `dmidecode -t4|awk '/Handle / {print $2}'`; do 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Socket Designation"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Family"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Manufacturer"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Current Speed"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Voltage"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
   echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Core Count"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
done
