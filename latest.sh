#!/bin/bash
latest_version=`curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/CHANGELOG.txt|grep '*vDDoS-' |awk 'NR==1' |tr -d '*vDDoS-'|tr -d ':'`
curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-$latest_version-centos7 -o /usr/bin/vddos
chmod 700 /usr/bin/vddos
/usr/bin/vddos help
/usr/bin/vddos setup
