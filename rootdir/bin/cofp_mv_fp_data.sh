#!/system/bin/sh
LOG_TAG="fp_move_data"
logi ()
{
	/system/bin/log -t $LOG_TAG -p i "$@"
}

checkUserData=`mount | grep "/data type ext4"`
an_fp_data_file="/data/system/users/0/fpdata/user_data_0"
ap_fp_data_folder="/data/vendor_de/0/fpdata"
upper_bound=150 #about 5 minutes
file_upper_bound=15 #about 30 seconds

mv_file() {

	#add loop to check android N fp data file: /data/system/users/0/fpdata/user_data_0
	loop_count=0
	while [ ! -f "$an_fp_data_file" -a "$loop_count" -le "$file_upper_bound" ]
	do
		#logi "$an_fp_data_file not found, sleep 2s and loop_count = $loop_count"
		sleep 2
		(( loop_count++ ))
	done

	if [ -f "$an_fp_data_file" ]; then
		logi "Found $an_fp_data_file, keep going."

		#add loop to check android P fp data folder: /data/vendor_de/0/fpdata
		loop_count=0
		while [ ! -d "$ap_fp_data_folder" -a "$file_upper_bound" -le "$file_upper_bound" ]
		do
			#logi "$ap_fp_data_folder not found, sleep 2 second and loop_count = $loop_count."
			sleep 2
			(( loop_count++ ))
		done

		if [ -d "$ap_fp_data_folder" ]; then
			logi "Found $ap_fp_data_folder, keep going."
			cp  $an_fp_data_file $ap_fp_data_folder/
			chown system:system $ap_fp_data_folder/*
			#setprop persist.asus.fp_data_copied 1
			rm -rf /data/system/users/0/fpdata
		else
			logi "Don't find $ap_fp_data_folder in upper bound: $loop_count"
		fi
	else
		logi "Don't find $an_fp_data_file in upper bound: $loop_count"
	fi
}

#add loop to check data partition is mounted or not.
logi "checkUserData = $checkUserData"
loop_count=0
while [ "$checkUserData" = "" -a "$loop_count" -le "$upper_bound" ]
do
	#logi "Data partition not ready, sleep 2 second. loop_count = $loop_count."
	sleep 2
	checkUserData=`mount | grep "/data type ext4"`
	(( loop_count++ ))
done

sleep 3

if [ "$checkUserData" != "" ]; then
	logi "Data partition is ready."
	mv_file
else
	logi "Don't find data partition in upper bound: $upper_bound"
fi
