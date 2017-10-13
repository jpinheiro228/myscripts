#! /bin/bash
# Upload's file or folder (.tar.gz compacted) to server.
if [ $# -eq 1 ]; then
    echo "No destination specified. Using default (pi@gtel-pi3-1.local:~/webShare/). File will be availabe at http://gtel-pi3-1.local/"
    DEST="pi@gtel-pi3-1.local:~/webShare/"

elif [ $# -eq 2 ]; then
    DEST=$2

elif [ $# -eq 0 ]; then
    echo "Please provide at least source file. If no destination specified, it will be sent to pi@gtel-pi3-1.local:~/webShare/ and will be available at http://gtel-pi3-1.local/"
    echo "./$0 SOURCE DESTINATION"
    exit 1
fi

SOURCE=$1
tmp_file="`basename $SOURCE`.tar.gz"

if [ -d $SOURCE ]; then
    tar -zcpf $tmp_file $SOURCE
    scp $tmp_file $DEST
    rm -f $tmp_file

elif [ -f $SOURCE ]; then
    scp $SOURCE $DEST
fi
