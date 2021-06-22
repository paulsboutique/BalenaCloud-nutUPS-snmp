# nutUPS Balena-cloud / OS Docker

Docker image forked for Balena-cloud / OS.<br>
Compiled for Raspberry pi 2<br>
Has the following:<br>
-NUT UPS Server<br>
-webNUT interface<br>
-snmpd <br>
-extended snmp for Librenms to graph power, runtime etc.<br>
<br>
edit the following files:<br>
-ups.conf to suit your UPS driver<br>
-snmpd.conf and change the ip address to suit your monitor software. ie: librenms server ip.<br>
<br>
use balena-cli to upload:<br>
-balena push "your application"<br> 
<br>
webNUT is accessible at the device "ip address":6543<br>
add your device into librenms via snmp and enjoy.<br>
<br>
<br>
thanks to https://github.com/jakezp for the original docker.



