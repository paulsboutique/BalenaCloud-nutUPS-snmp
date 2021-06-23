#!/bin/sh


# Set to standalone mode
sed -i 's/MODE=none/MODE=standalone/g' /etc/nut/nut.conf

# Set permissions
chgrp -R nut /etc/nut /dev/bus/usb
chmod -R o-rwx /etc/nut
chmod +x /etc/snmp/ups-nut.sh
chmod +x /etc/snmp/ups.sh


# Start nut services in order
exec /sbin/upsdrvctl start &
sleep 45
/sbin/upsd
sleep 15
/sbin/upsmon
sleep 30
/usr/sbin/snmpd
sleep 15

cd /app/webNUT/webnut
pserve ../production.ini
