#!/bin/sh
if [ -e /etc/init.d/repair_ro ]; then
    rm /etc/init.d/repair_ro
else
    wget --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/etc/init.d/repair_ro -O /etc/init.d/repair_ro && chmod +x /etc/init.d/repair_ro
    wget --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/usr/bin/repair_ro -O /usr/bin/repair_ro && chmod +x /usr/bin/repair_ro
    sed -i '/exit 0/i /etc/init.d/repair_ro' /etc/rc.local
    rm /tmp/install.sh
fi
