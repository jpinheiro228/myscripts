#! /bin/bash
# TAR OVER SSH SCRIPT.
# COPIES FILE OR FOLDER TO A SERVER OVER SSH, PRESERVING FILE PERMISSIONS AND LINKS.
if [ $# -ne 2 ]; then
    echo "Please provide source and destination (USER@SERVER)!"
    echo ".$0 SOURCE DESTINATION"
    exit 1
fi

SOURCE=$1
DEST=$2

tar -zcpf - $SOURCE | ssh $DEST '( tar zxf - )'
