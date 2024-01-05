# Fix read-only root file system

[![Translate](https://img.shields.io/badge/Translate-Indonesian-brightgreen)](README-ID.md)

This script is designed to automatically repair a read-only root file system on OpenWrt devices. It checks if the file system is in read-only mode and initiates the repair process using the **e2fsck** command. 
This script also detects where the system root partition is located before run the command. 
If the repair is successful, it restores the file system to read-write mode and try performs a reboot to apply the changes.

The operating system can experience read-only problems due to sudden power loss which means that the process of writing data to the system is not completed or is interrupted suddenly, this can cause damage to operating system data.

**Usage Instructions:**
1. Ensure you have access to an OpenWrt device with a file system that needs repair.
2. Connect to the device using SSH or a terminal.
3. Install the script by running the following command:
  ```
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/install.sh)"
  ```

4. Run the script manually with the following command:
  ```
  /sbin/repair_ro
  ```
  or directly call the script using:
  ```
  repair_ro
  ```
  you can also run the script using argumen input as alternate for more spesific rootfs device, eg.
  ```
  /sbin/repair_ro /dev/mmcblk0p2
  ```
  or
  ```
  repair_ro /dev/sda2
  ```
  
  **Note:** 
* Run the script again if fail to fix ro while boot proccess.
* If the repair is success, the script will reboot the system to apply the changes.
* You need reboot manually if the script fail to reboot after fixing the ro file system.
