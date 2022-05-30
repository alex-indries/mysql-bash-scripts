#!/bin/sh

#THIS CREATES A BACKUP FOR THE DATABASE CREATED WITH THE OTHER SCRIPT
echo "starting db backup"
hour="$(date +'%I')"
db_backup="mydb_${hour}.sql"
mysqldump -u root -p verticalDB > Users/ghbsoftware/Documents/TaskScript/${db_backup}
echo "db backup complete"

echo "#######################"

dumpsize=$(stat -c%s "$db_backup")
if [ -e history.csv ]
then
        printf '%s\n' $date $hour ${dumpsize} bytes | paste -sd ' ' >> history.csv
else
        printf '%s\n' DATA ORA DumpSize | paste -sd ' ' >> history.csv
        printf '%s\n' $date $hour ${dumpsize} bytes | paste -sd ' ' >> history.csv
fi
#For this you need to have a s3 bucket created. 
aws s3 cp $db_backup s3://mysql-files-bucket/back-up/
