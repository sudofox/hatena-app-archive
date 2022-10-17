#!/bin/bash

# download android package with googleplay
# Usage: ./download.sh <package_name> [optional version]

if [ $# -ne 2 ]; then
    echo "Usage: ./download.sh <package_name> <numeric version code>"
    exit 1
fi

PACKAGE=$1
VERSION=$2

# fixes for bugs (existing as of 2021-08-17)
# https://github.com/NoMore201/googleplay-api/issues/132#issuecomment-671605973

./googleplay -a $PACKAGE -v $2
