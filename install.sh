#!/bin/sh
if [ -e /usr/bin/repair_ro ]; then
    rm /usr/bin/repair_ro
fi
echo "Installing..."
wget --quiet --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/usr/bin/repair_ro -O /usr/bin/repair_ro  > /dev/null  2>&1

echo "Setting permission..."
chmod +x /usr/bin/repair_ro  > /dev/null

echo "Adding to startup..."
if ! grep -q '/usr/bin/repair_ro' /etc/rc.local; then
    sed -i '/exit 0/i /usr/bin/repair_ro' /etc/rc.local 2>/dev/null
fi

echo "Cleaning..."
rm /tmp/install.sh  > /dev/null

echo "Success!"
