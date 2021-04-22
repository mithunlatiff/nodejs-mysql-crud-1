#!/bin/sh
HOOK_RETRIES=10000
curl -s https://raw.githubusercontent.com/mithunlatiff/nodejs-mysql-crud-1/master/database/db.sql -o /tmp/db.sql
while [ "$HOOK_RETRIES" != 0 ]; do
    if mysql -htododb -u$MYSQl_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &> /dev/null; then
        echo "Database is up"
        break
        else
        echo "Database down"
        let HOOK_RETRIES=HOOK_RETRIES-1
    fi    
done
if [ "$HOOK_RETRIES" == 0 ]; then
exit 1
fi
if mysql -htododb -u$MYSQl_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/db.sql; then 
echo "DB Updated success"
exit 0
else
echo "Failed"
exit 1
fi