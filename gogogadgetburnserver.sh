apt install snmpd lm-sensors unattended-upgrades apt-listchanges git build-essential cmake libuv1-dev libssl-dev libhwloc-dev htop vim net-tools
echo "Debian-snmp ALL = NOPASSWD: /usr/sbin/dmidecode" > /etc/sudoers.d/snmp
echo "snmp ALL = NOPASSWD: /usr/sbin/dmidecode" >> /etc/sudoers.d/snmp

for f in /sys/devices/system/cpu/vulnerabilities/*; do echo "${f##*/} -" $(cat "$f"); done
