#!/bin/sh
HOOK_RETRIES=90
HOOK_SLEEP=10
curl -s https://raw.githubusercontent.com/mithunlatiff/nodejs-mysql-crud-1/master/database/db.sql -o /tmp/db.sql
while [ "$HOOK_RETRIES" != 0 ]; do
    if mysqlshow -htododb -u$MYSQL_USER -p$MYSQL_PASSWORD -P3306 $MYSQL_DATABASE; then
        echo "Database is up"
        break
        else
        echo "Database down"
        sleep $HOOK_SLEEP
    fi  
    let HOOK_RETRIES=HOOK_RETRIES-1  
done
if [ "$HOOK_RETRIES" = 0 ]; then
    echo "Unable to connect"
    exit 1
fi
if mysql -htododb -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/db.sql; then 
    echo "DB Updated success"
else
    echo "Failed"
    exit 2
fi