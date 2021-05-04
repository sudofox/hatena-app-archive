#!/bin/bash

for i in $(find -type f |grep "\.apk"); do echo "===== $i ====="; apksigner verify --print-certs $i ; done|grep -v WARNING | tee signatures.txt
