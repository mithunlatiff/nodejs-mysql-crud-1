#!/bin/sh
HOOK_RETRIES=90
HOOK_SLEEP=10
curl -s https://raw.githubusercontent.com/mithunlatiff/nodejs-mysql-crud-1/master/database/db.sql -o /tmp/db.sql
while [ "$HOOK_RETRIES" != 0 ]; do
    if mysqlshow -h$MYSQL_SERVICE_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &>/dev/null; then
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
if mysql -h$MYSQL_SERVICE_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/db.sql; then 
    echo "DB Updated success"
else
    echo "Failed"
    exit 2
fi