#!/bin/bash

# User configuration
hostname=Your_Hostname
username=Your_Username
password=Your_Password
delay=900

# Get the current ip address
old_address=$(curl -s http://whatismyip.akamai.com/)

# Loop forever
while true
do
	# Save the current ip address
	current_address=$(curl -s "http:whatismyip.akamai.com/")

	# Check if the ip address has changed
	if [[ "$current_address" != "$old_address" ]]
	then
		curl -u "$username:$password" "http://www.ovh.com/nic/update?system=dyndns&hostname=$hostname&myip=$current_address"
	fi

	# Update the old ip address
	((old_address = current_address))

	# Wait for the set amount of seconds
	sleep $delay
done
