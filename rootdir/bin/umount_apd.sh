#!/system/bin/sh

# This service is for ASUS Product Demo

chmod 775 /APD/* -R 
chown system:system /APD/* -R

umount /APD
