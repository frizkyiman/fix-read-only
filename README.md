# Fix read-only root file system

[![Translate](https://img.shields.io/badge/Translate-Indonesian-brightgreen)](README-ID.md)

This script is designed to automatically repair a read-only root file system on OpenWrt devices. It checks if the file system is in read-only mode and initiates the repair process using the **e2fsck** command. 
This script also detects where the system root partition is located before run the command. 
If the repair is successful, it restores the file system to read-write mode and try performs a reboot to apply the changes.

**Usage Instructions:**
1. Ensure you have access to an OpenWrt device with a file system that needs repair.
2. Connect to the device using SSH or a terminal.
3. Install the script by running the following command:
  ```
  wget --quiet --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/install.sh -O /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh
  ```

4. Run the script manually with the following command:
  ```
  /usr/bin/repair_ro
  ```
  or using:
  ```
  repair_ro
  ```
  you can also run the script using argumen input as alternate for more spesific rootfs device, eg.
  ```
  repair_ro /dev/mmcblk0p2
  ```
  or
  ```
  repair_ro /dev/sda2
  ```
5. Add script to startup (optional)
  ```
  nano /etc/rc.local
  ```
  add this before exit 0
  ```
  repair_ro
  ```
  
  **Note:** 
* Run the script again if fail to fix ro while boot proccess.
* If the repair is successful, the script will reboot the system to apply the changes.
* You need reboot manually if the script fail to reboot after fixing the ro file system.
