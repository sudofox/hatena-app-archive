#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ANDROID_DIR="$DIR/../android"

for i in $(find $ANDROID_DIR -type f | grep "\.apk"); do
  echo "===== $i ====="
  apksigner verify --print-certs $i
done | grep -v WARNING | tee signatures.txt
