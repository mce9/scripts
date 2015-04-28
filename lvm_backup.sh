#!/bin/bash

NOW=$(date +%F)
KVM_ARRAY=(mink jira marmot confluence git bonobo)
NAS=//place/to/store/things
BACKUP_DIR=/path/to/backups
VG_NAME=

#Checks for a directory mount the NAS and creates one if needed
echo "Checking for a dir to mount the NAS.."
if [ -d /backups/unc ]
	then
		echo "Dir exists, moving on.."
else
	mkdir -p /backups/unc
	echo "Dir has been created.."
fi

#Mounts the NAS
mount -t cifs $NAS $BACKUP_DIR -o user=,password=""

for i in {0..5}
do
        #Takes an LVM snapshot
        lvcreate -L10G -s -n ${KVM_ARRAY[i]}.$NOW /dev/$VG_NAME/${KVM_ARRAY[i]}.com-disk1
        echo "Creating the LVM snapshot for ${KVM_ARRAY[i]}..."
        #Mounts the snapshot to a dir in /mnt
		mkdir /mnt/${KVM_ARRAY[i]}
        mount -t ext4 /dev/$VG_NAME/${KVM_ARRAY[i]}.$NOW /mnt/${KVM_ARRAY[i]}
        #Tars and gzips the snapshot
        tar -pczf /backups/${KVM_ARRAY[i]}.$NOW.tar.gz /mnt/${KVM_ARRAY[i]}
        umount /mnt/${KVM_ARRAY[i]}
        lvremove -f /dev/$VG_NAME/${KVM_ARRAY[i]}.$NOW
done

#Copies the backups to the NAS 
cp /backups/*.tar.gz $BACKUP_DIR

umount $BACKUP_DIR
