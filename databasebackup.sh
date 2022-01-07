${DB} | wc -l`

#below command will create variable with today date and time
TODAY=`date +"%d-%m-%y-%T"`

#variables having details about path and sql
BACKUP_PATH='/home/ubuntu/tmp'
HOST='localhost'
USER='vishal'
PASS='Vishal@1'
DB='VISHAL'

echo "Initiating backup of ${DB}..."

#command to create database backup and store into desired path..
mysqldump -h ${HOST} -u ${USER} -p${PASS} ${DB} > ${BACKUP_PATH}/${DB}-${TODAY}.sql

#conditional statement to check success code FYI Exit code 0 is for sucessfully execution on command
if [ $? -eq 0 ]; then
        echo "Backup of database ${DB} has been succesfully created.."
else
        echo "Error found.."
fi

#here to count number of backup files avilable
count=`ls ${BACKUP_PATH}|grep ${DB} | wc -l`

#condition to remove trash automatically
if [ $count -gt 7 ]; then
        rm -f ${BACKUP_PATH}/$(ls -Str ${BACKUP_PATH} | grep -v test  | head -1)
fi
