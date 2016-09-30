import netmiko
import getpass
import datetime
import time

def get_command():
	# this function takes commands and creates a list

	commands = []
	print "[*] Enter the commands you want to send to the network device. Type \'done\' when finished."

	while True:
		var = raw_input("Command: ")
		commands.append(var)
		if var == "done":
			break

	commands.remove("done")
	print "Commands that will be sent to the network device: " + str(commands)
	return commands

def get_devices():
	# this function takes input and creates a list of hosts to connect to.

	print "[*] Enter a comma-separated list of IP addresses"
	device_list = raw_input("Hosts: ")

	devices = device_list.split(',')
	device_count = len(devices)

	print "[*] Number of devices to configure: " + str(device_count)

	return devices

def get_username():
	# asks for the username to be used to connect to the network device

	print "[*] Enter the username for the device(s)"
	username = raw_input("Username: ")
	return username

def get_device_type():
	# netmiko supports connecting to a range of network devices
	# asks the user which type of device they're connecting to

	print "[*] Enter the device type."
	print "[*] The available device types are:"
	print "\t\'cisco_ios\',"
	print "\t\'cisco_xe\',"
	print "\t\'cisco_asa\',"
	print "\t\'cisco_nxos\',"
	print "\t\'cisco_xr\',"
	print "\t\'cisco_wlc_ssh\',"
	print "\t\'arista_eos\',"
	print "\t\'hp_procurve\',"
	print "\t\'hp_comware\',"
	print "\t\'huawei\',"
	print "\t\'f5_ltm\',"
	print "\t\'juniper\',"
	print "\t\'brocade_vdx\'."
	device_type = raw_input("Type: ")
	return device_type

def device_connect(dev_type, device_list, command_list, username, password):
	# takes five arguments supplied by previous connections, and
	# iterates through the list of devices, makes an SSH connection,
	# and runs the provided commands

	for router in device_list:
		connection = netmiko.ConnectHandler(device_type = dev_type, ip = router, username = username, password = password)

		connection.send_config_set(command_list)
		print router + " is complete"
		time.sleep(2)

device_list = get_devices()		# list of network devices
command_list = get_command()	# list of commands to be run
username = get_username()				# username to be used
password = getpass.getpass()	# password to be used
dev_type = get_device_type()	# the type of device 

device_connect(dev_type, device_list, command_list, username, password)
