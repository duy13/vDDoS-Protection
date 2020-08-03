#!/bin/bash

# Test connection:
/usr/bin/curl --silent --header "X-Install: vDDoS" https://files.voduy.com/iplog.php
/usr/bin/curl -s -w 'Testing Connection Response Time for: github.com\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/latest.sh
/usr/bin/curl -s -w 'Testing Connection Response Time for: sourceforge.net\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null https://sourceforge.net/projects/vddos-protection/files/latest.sh/download
/usr/bin/curl -s -w 'Testing Connection Response Time for: files.voduy.com\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null https://files.voduy.com/vDDoS-Proxy-Protection/latest.sh


# Install vDDoS Proxy Protection:
latest_version=`/usr/bin/curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/CHANGELOG.txt|grep '*vDDoS-' |awk 'NR==1' |tr -d '*vDDoS-'|tr -d ':'`
/usr/bin/curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-$latest_version-centos7 -o /usr/bin/vddos

originhash=`curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/md5sum.txt --silent | grep "vddos-$latest_version-centos7" |awk 'NR=1 {print $1}'`
downloadhash=`md5sum /usr/bin/vddos | awk 'NR=1 {print $1}'`
if [ "$originhash" != "$downloadhash" ]; then
	echo 'Download vddos-'$latest_version'-centos7 from Github.com failed! Try Downloading from SourceForge.net...'
	rm -rf /usr/bin/vddos
	curl -L https://sourceforge.net/projects/vddos-protection/files/vddos-$latest_version-centos7 -o /usr/bin/vddos --silent

	originhash=`curl -L https://sourceforge.net/projects/vddos-protection/files/md5sum.txt --silent | grep "vddos-$latest_version-centos7" |awk 'NR=1 {print $1}'`
	downloadhash=`md5sum /usr/bin/vddos | awk 'NR=1 {print $1}'`
	if [ "$originhash" != "$downloadhash" ]; then
		echo 'Download vddos-'$latest_version'-centos7 from SourceForge.net failed! Try Downloading from Files.voduy.com...'
		rm -rf /usr/bin/vddos
		curl -L https://files.voduy.com/vDDoS-Proxy-Protection/vddos-$latest_version-centos7 -o /usr/bin/vddos --silent
	fi

fi

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