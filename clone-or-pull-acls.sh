#!/bin/bash

echo "Fetching or updating the wayback_excludes_update access control lists in ${STORAGE_PATH_SHARED}..."

# Change to working directory:
cd ${STORAGE_PATH_SHARED}

# Set up variables:
FOLDER=wayback_excludes_update
URL=https://git.wa.bl.uk/bl-services/wayback_excludes_update.git

# Clone or pull as appropriate:
if [ ! -d "$FOLDER" ] ; then
    git clone $URL $FOLDER
else
    cd $FOLDER
    git pull $URL
fi