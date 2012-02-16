#!/usr/bin/env bash
# Script to gather the list of additionally installed packages on OpenWRT
# Author non7top@gmail.com
# Dec 2011

#Read all destinations from opkg config
DESTINATIONS=`awk '/dest/ {print $3}' /etc/opkg.conf`

while read DEST
do
    
    # For / destination we use /overlay instead to get only custom packages
    if [ "x${DEST}" == "x/" ];then
        DEST="/overlay"
    fi
    
    # Catch all packages for destination
    PACKAGES="`ls ${DEST}/usr/lib/opkg/info/*control -1 2> /dev/null|awk -F [\/\.] '{print $7}'`"
    
    # Skip destinations with no packages
    if [ -z "${PACKAGES}" ];then
        continue
    fi
    
    while read PKG
    do
        LN=`opkg whatdependsrec $PKG|wc -l`
        #echo $LN $PKG
        # Dependencies go after 3rd line
        if [ $LN -eq 3 ]; then
            echo $PKG $DEST
        fi
        
     done <<< "$PACKAGES"

done <<< "$DESTINATIONS"

exit 0

