#!/bin/sh
IP=192.168.0.101
timer=30
events=500
throttle=350

adb usb
sleep 2
adb tcpip 5555
sleep 5
#TODO: Get args from terminal
adb connect $IP
sleep 3
connectStatus=`adb devices|wc -l`
if [[ $connectStatus -gt 3 ]]; then
	echo "Safe to Disconnect"
	for i in `seq $timer 1`;
	do
	        echo $i
	        sleep 1
	done
	echo "Operation Monkey Commenced"
	#Throttle optional
	adb shell monkey -v $events --throttle $throttle --ignore-crashes --ignore-timeouts --ignore-security-exceptions
else
	echo "Couldn't Connect to device"
fi