#!/system/bin/sh

fw_ver=$(cat /proc/fwver_info)

setprop touch.version.driver "$fw_ver"
