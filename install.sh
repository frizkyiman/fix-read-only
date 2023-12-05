#!/bin/sh
if [ -e /usr/bin/repair_ro ]; then
    rm /usr/bin/repair_ro
fi
echo "Installing..."
wget --no-check-certificate -nv https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/sbin/repair_ro -O /sbin/repair_ro  > /dev/null  2>&1
wget --no-check-certificate -nv https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/etc/init.d/repair_ro -O /usr/bin/repair_ro  > /dev/null  2>&1

echo "Setting permission..."
chmod +x /sbin/repair_ro  > /dev/null
chmod +x /etc/init.d/repair_ro  > /dev/null

echo "Adding to startup..."
etc/init.d/repair_ro enable
etc/init.d/repair_ro start

echo "Success!"
rm "$0"
