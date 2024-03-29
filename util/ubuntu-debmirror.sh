#!/bin/bash

## Setting variables with explanations.

#
# Don't touch the user's keyring, have our own instead
#
export GNUPGHOME=/tmp

# Add check of available packages, like rsync, gpg and debmirror

if [ ! -f /tmp/trustedkeys.gpg ]; then
    gpg --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export|gpg --no-default-keyring --keyring /tmp/trustedkeys.gpg --import
fi

arch=i386,amd64
section=main,restricted,universe,multiverse
release=focal,focal-security,focal-updates
server=archive.ubuntu.com
inPath=/ubuntu
proto=rsync

# Outpath=              # Directory to store the mirror in
# Make this a full path to where you want to mirror the material.
#
outPath=/mirror/

# The --nosource option only downloads debs and not deb-src's
# The --progress option shows files as they are downloaded
# --source \ in the place of --no-source \ if you want sources also.
# --nocleanup  Do not clean up the local mirror after mirroring is complete. Use this option to keep older repository
# Start script
#
debmirror       -a $arch \
                --no-source \
                -s $section \
                -h $server \
                -d $release \
                -r $inPath \
                --progress \
                --method=$proto \
                $outPath

