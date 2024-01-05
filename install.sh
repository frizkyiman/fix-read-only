#!/bin/sh

if [ -e /sbin/repair_ro -a -e /etc/init.d/repair_ro -a -e /usr/bin/repair_ro ]; then
    rm /sbin/repair_ro
    rm /usr/bin/repair_ro
    rm /etc/init.d/repair_ro
fi

if ! command -v blkid &> /dev/null; then
    echo "Installing component"
    opkg update
    opkg install blkid
fi

echo "Installing..."
wget --no-check-certificate -nv https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/sbin/repair_ro -O /sbin/repair_ro  > /dev/null  2>&1

cat <<'EOF' >/etc/init.d/repair_ro
#!/bin/sh /etc/rc.common

START=99

start() {
    /sbin/repair_ro
}
EOF

cat <<'EOF' >/usr/bin/repair_ro
#!/bin/sh
root_device="$1"
/sbin/repair_ro "$root_device"
EOF

echo "Setting permission..."
chmod +x /sbin/repair_ro  > /dev/null
chmod +x /etc/init.d/repair_ro  > /dev/null
chmod +x /usr/bin/repair_ro  > /dev/null

echo "Adding to startup..."
/etc/init.d/repair_ro enable
/etc/init.d/repair_ro start

echo "Success!"
