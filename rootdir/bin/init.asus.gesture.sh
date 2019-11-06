#!/system/bin/sh
gesture_type=`getprop persist.asus.gesture.type`
dclick=`getprop persist.asus.dclick`
swipeup=`getprop persist.asus.swipeup`
gesture_set=0
if [ -d "/sys/bus/i2c/devices/i2c-4/4-0062" ] || [ -d "/sys/bus/i2c/devices/i2c-4/4-0070" ]; then
	gesture_set=$(($((((2#$gesture_type))<<2)) + $((((2#$dclick))<<1)) + $((2#$swipeup))))
	echo $gesture_set > /proc/goodix_gesture
else
	echo "NO this panel!"
fi
