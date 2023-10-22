#!/bin/sh
if [ -e /etc/init.d/repair_ro ]; then
    rm /etc/init.d/repair_ro
fi
echo "Installing..."
wget --quiet --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/etc/init.d/repair_ro -O /etc/init.d/repair_ro  > /dev/null  2>&1
wget --quiet --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/usr/bin/repair_ro -O /usr/bin/repair_ro  > /dev/null  2>&1

echo "Setting permission..."
chmod +x /etc/init.d/repair_ro  > /dev/null
chmod +x /usr/bin/repair_ro  > /dev/null

echo "Adding to startup..."
sed -i '/exit 0/i /etc/init.d/repair_ro' /etc/rc.local  > /dev/null

echo "Cleaning..."
rm /tmp/install.sh  > /dev/null

echo "Success!"
