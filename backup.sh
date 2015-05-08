#!/bin/bash
NOW=$(date +"%Y-%m-%d-%H%M")
FILE="wpserver.$NOW.tar"
BACKUP_DIR="/root"
WWW_DIR="/var/www"
DB_USER="root"
DB_PASS="XeyecrA3#6"
DB_NAME="wordpress"
DB_FILE="wpserver.$NOW.sql"
WWW_TRANSFORM='s,^var/www,www,'
DB_TRANSFORM='s,^root,database,'

tar -cvf $BACKUP_DIR/$FILE --transform $WWW_TRANSFORM $WWW_DIR
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$DB_FILE

tar --append --file=$BACKUP_DIR/$FILE --transform $DB_TRANSFORM $BACKUP_DIR/$DB_FILE
rm $BACKUP_DIR/$DB_FILE
chmod 700 $BACKUP_DIR/$FILE
gzip -9 $BACKUP_DIR/$FILE

