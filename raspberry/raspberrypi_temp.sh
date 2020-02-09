# cat /sys/class/thermal/thermal_zone0/temp
watch -n 2 "vcgencmd measure_temp"
