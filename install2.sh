#!/bin/bash

# Main program
main() {
cat <<'EOF' >/sbin/repair_ro
#!/bin/sh
# Created by Frizkyiman
# Github https://github.com/frizkyiman/

_echo() {
  [ "$1" = 'err' ] && echo $2 >&2 || echo $2
  logger -p "$1" -t repair_co "$2"
}

if [ -n "$1" ]; then
    root_device="$1"
    if ! blkid | grep -q "$root_device:"; then
        _echo err "Root file system device '$root_device' not found in the system. Unable to repair."
        exit 1
    fi
else
    root_device=$(blkid -L rootfs -o device)
fi

if [ -z "$root_device" ]; then
    _echo err "Root file system device not found in the system. Unable to repair."
    exit 1
fi

ro_status=$(mount | awk '/\/dev\/root/ && /ro,/ {print $6}' | grep -o 'ro' | head -n 1)

if [ "$ro_status" = "ro" ]; then
    _echo notice "Detected root file system: $root_device"
    _echo notice "The file system is currently read-only. Initiating repair..."

    if e2fsck -y "$root_device"; then
        _echo notice "File system repair successful."
        _echo notice "Mounting $root_device to read-write"
        mount -o remount,rw "$root_device" /
        _echo notice "Rebooting the system..."
        reboot
        if [ $? -ne 0 ]; then
            _echo err "Reboot command failed. Please try force reboot if necessary using reboot -f"
        fi
    else
        _echo notice "An error occurred while repairing the file system."
        _echo notice "Trying to reboot if possible"
        _echo notice "please try force reboot if nothing happen using reboot -f"
        reboot
        if [ $? -ne 0 ]; then
            _echo err "Reboot command failed. Please try force reboot if necessary using reboot -f"
        fi
    fi
else
    _echo notice "Root file system device '$root_device' is currently in read-write mode."
fi
EOF
}

# Support file
component() {
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
}

# Check requaried tools installed
prepare() {
 if ! command -v blkid &> /dev/null; then
     echo "Installing requaried tools"
     opkg update
     opkg install blkid
 fi
}

# Setup permission
permission() {
 echo "Setting permission..."
 chmod +x /sbin/repair_ro
 chmod +x /etc/init.d/repair_ro
 chmod +x /usr/bin/repair_ro
 echo "Adding to startup..."
 /etc/init.d/repair_ro enable
 echo "Success!"
 rm "$0"
}

# Perform related operations
echo "Installing"
prepare
main
component
permission
