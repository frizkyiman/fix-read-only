# Fix read-only root file system

[![Translate](https://img.shields.io/badge/Translate-English-brightgreen)](README.md)

Skrip ini dirancang untuk secara otomatis memperbaiki sistem file root yang hanya bisa dibaca pada perangkat OpenWrt. Skrip ini akan memeriksa apakah sistem file berada dalam mode hanya baca dan memulai proses perbaikan menggunakan perintah e2fsck. Skrip ini juga akan mendeteksi lokasi partisi root sistem sebelum menjalankan perintah. Jika perbaikan berhasil, maka sistem file akan dikembalikan ke mode tulis dan mencoba melakukan reboot untuk menerapkan perubahan.

**Instruksi Penggunaan:**
1. Pastikan Anda memiliki akses ke perangkat OpenWrt dengan sistem file yang perlu diperbaiki.
2. Sambungkan ke perangkat menggunakan SSH atau terminal.
3. Pasang skrip ini dengan menjalankan perintah berikut:

  ```
  wget --no-check-certificate -q https://raw.githubusercontent.com/frizkyiman/fix-read-only/main/install.sh -O /tmp/install.sh && chmod +x /tmp/install.sh && /tmp/install.sh
  ```

4. Jalankan skrip secara manual dengan perintah berikut:
  ```
  /sbin/repair_ro
  ```
  atau dengan:
  ```
  repair_ro
  ```
  Anda juga dapat menjalankan skrip dengan argumen input sebagai alternatif untuk perangkat rootfs yang lebih spesifik, misalnya:
  ```
  /sbin/repair_ro /dev/mmcblk0p2
  ```
  atau
  ```
  repair_ro /dev/sda2
  ```
5. Tambahkan skrip ke startup (opsional)
  ```
  nano /etc/rc.local
  ```
  tambahkan ini sebelum exit 0
  ```
  /sbin/repair_ro
  ```
  
**Catatan:** 

*Jalankan skrip lagi jika gagal memperbaiki sistem file yang hanya bisa dibaca saat proses booting.

*Jika perbaikan berhasil, skrip akan me-reboot sistem untuk menerapkan perubahan.

*Anda perlu me-reboot secara manual jika skrip gagal me-reboot setelah memperbaiki sistem file yang hanya bisa dibaca.
