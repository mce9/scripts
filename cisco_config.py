import netmiko
import getpass
import datetime

device_list = ['10.0.9.1','10.0.17.1','10.0.18.1','10.0.22.1','10.0.28.1','10.0.52.1','10.0.53.1','10.0.56.1','10.0.58.1','10.0.60.1','10.0.61.1','10.0.64.1','10.0.66.1','10.0.69.1','10.0.76.1','10.0.151.1']
username = 'admin'
password = getpass.getpass()
command = ['ip name-server 10.0.0.224 10.0.0.225','no ip name-server 10.0.0.222']

print "Start time: " + str(datetime.datetime.now())

for router in device_list:
	connection = netmiko.ConnectHandler(device_type = 'cisco_ios', ip = router, username = username, password = password)

	connection.send_config_set(command)
	print router + " is complete."

print "End time: " + str(datetime.datetime.now())
