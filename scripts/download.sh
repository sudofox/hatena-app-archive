#!/bin/bash

# download android package with gplaycli
# Usage: ./download.sh <package_name> [optional version]

if [ $# -ne 1 ]; then
    echo "Usage: ./download.sh <package_name> [optional version]"
    exit 1
fi

# fixes for bugs (existing as of 2021-08-17)
# https://github.com/matlink/gplaycli/issues/260#issuecomment-778663387
# https://github.com/NoMore201/googleplay-api/issues/132#issuecomment-671605973

python -m gplaycli -c ./gplaycli.conf -av -p -v -d $1