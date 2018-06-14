#!/bin/bash
HOST=""
USER=""
DATABASE=""
PASSWORD=""
if [ $# == 0 ];
then
echo "input csv file name,please!";exit;
fi
TABLE=$1
COPYPATH="/data/htdocs/Master/"
COPYFILE=${COPYPATH}${TABLE}.csv
LOADPATH="/var/lib/mysql-files/"
LOADFILE=${LOADPATH}${TABLE}.csv

if [ -f "$COPYFILE" ]
then
 echo "$TABLE found."
else
 echo "$TABLE not found.";exit;
fi

echo "==========start=================";
cp ${COPYPATH}${TABLE}.csv $LOADPATH

if [ -f "${LOADPATH}${TABLE}.csv" ]
then
 echo "copy a file success!"
else
 echo "copy a fale failed!";exit;
fi
#mysql -h$HOST -u$USER -p$PASSWORD $DATABASE < load_csv.sql
echo "Loading a csv file"
mysql -h$HOST -u$USER -p$PASSWORD $DATABASE <<EOF
TRUNCATE TABLE $TABLE;
LOAD DATA LOCAL INFILE '$LOADFILE' INTO TABLE $TABLE character set utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' IGNORE 1 LINES
EOF
echo "=========end===================";
