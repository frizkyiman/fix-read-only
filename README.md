# Fix Read only filesystem
This script is designed to automatically repair a read-only file system on OpenWrt devices using the init.d system. It checks if the file system is in read-only mode and initiates the repair process using the **'e2fsck -y'** command. If the repair is successful, it restores the file system to read-write mode and optionally performs a reboot to apply the changes.

**Usage Instructions:**
1. Ensure you have access to an OpenWrt device with a file system that needs repair.
2. Connect to the device using SSH or a terminal.
3. Install the script by running the following command:
  ```
  wget --no-check-certificate https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/repair_ro -O /etc/init.d/repair_ro && chmod +x /etc/init.d/repair_ro
  ```
5. Replace *<'device'>* with your rootfs partition or what you like to fix (e.g., mmcblk0p2 or sda2).
  ```
  nano /etc/init.d/repair_ro
  ```
  (ctrl+x then Y then Enter to save change).
6. Enable the script to run at boot time by running the command:
  ```
  /etc/init.d/repair_ro enable
  ```
7. Run the script manually with the following command:
  ```
  /etc/init.d/repair_ro start
  ```
  The script will automatically check if the file system is read-only, repair it if needed, and restore it to read-write mode.
  
  **Note:** If the repair is successful, the script will offer the option to reboot the system to apply the changes. You can choose to reboot by typing 'y' and pressing Enter, or skip the reboot by typing 'n' and pressing Enter.
