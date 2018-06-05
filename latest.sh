#!/bin/bash
# Install vDDoS Proxy Protection:
latest_version=`curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/CHANGELOG.txt|grep '*vDDoS-' |awk 'NR==1' |tr -d '*vDDoS-'|tr -d ':'`
curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-$latest_version-centos7 -o /usr/bin/vddos
chmod 700 /usr/bin/vddos
/usr/bin/vddos help
/usr/bin/vddos setup

if [ -f /vddos/vddos ]; then
	echo 'Install vDDoS Proxy Protection Done!'
	yum -y install curl zip unzip  >/dev/null 2>&1
	# Install vDDoS Layer4 Mapping:
	curl -L https://github.com/duy13/vDDoS-Layer4-Mapping/raw/master/vddos-layer4-mapping -o /usr/bin/vddos-layer4 >/dev/null 2>&1
	chmod 700 /usr/bin/vddos-layer4
	echo 'Install vDDoS Layer4 Mapping Done!'

	# Install vDDoS Auto Add:
	curl -L https://github.com/duy13/vDDoS-Auto-Add/archive/master.zip -o vddos-auto-add.zip  >/dev/null 2>&1; unzip vddos-auto-add.zip  >/dev/null 2>&1; rm -f vddos-auto-add.zip
	mv vDDoS-Auto-Add-master /vddos/auto-add
	chmod 700 /vddos/auto-add/cron.sh; chmod 700 /vddos/auto-add/vddos-add.sh
	ln -s /vddos/auto-add/vddos-add.sh /usr/bin/vddos-add
	ln -s /vddos/auto-add/cron.sh /usr/bin/vddos-autoadd
	echo 'Install vDDoS Auto Add Done!'

	# Install vDDoS Auto Switch:
	curl -L https://github.com/duy13/vDDoS-Auto-Switch/archive/master.zip -o vddos-auto-switch.zip  >/dev/null 2>&1; unzip vddos-auto-switch.zip  >/dev/null 2>&1; rm -f vddos-auto-switch.zip
	mv vDDoS-Auto-Switch-master /vddos/auto-switch
	chmod 700 /vddos/auto-switch/cron.sh; chmod 700 /vddos/auto-switch/vddos-switch.sh
	ln -s /vddos/auto-switch/cron.sh /usr/bin/vddos-autoswitch
	ln -s /vddos/auto-switch/vddos-switch.sh /usr/bin/vddos-switch
	echo 'Install vDDoS Auto Switch Done!'
	exit 0
else
	echo 'Install vDDoS Proxy Protection Failed!'
	exit 1
fi