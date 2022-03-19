#!/bin/bash

# Test connection:
/usr/bin/curl --silent --header "X-Install: vDDoS" https://files.voduy.com/iplog.php
/usr/bin/curl -s -w 'Testing Connection Response Time for: github.com\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/latest.sh
/usr/bin/curl -s -w 'Testing Connection Response Time for: sourceforge.net\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null https://sourceforge.net/projects/vddos-protection/files/latest.sh/download
/usr/bin/curl -s -w 'Testing Connection Response Time for: files.voduy.com\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null https://files.voduy.com/vDDoS-Proxy-Protection/latest.sh


# Install vDDoS Proxy Protection:
if [ "$1" != "" ]; then
latest_version="$1"
else
latest_version=`/usr/bin/curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/CHANGELOG.txt|grep '*vDDoS-' |awk 'NR==1' |tr -d '*vDDoS-'|tr -d ':'`
fi
/usr/bin/curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz

originhash=`curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/md5sum.txt --silent | grep "vddos-$latest_version.tar.gz" |awk 'NR=1 {print $1}'`
downloadhash=`md5sum vddos-$latest_version.tar.gz | awk 'NR=1 {print $1}'`
if [ "$originhash" != "$downloadhash" ]; then
	echo 'Download vddos-'$latest_version'.tar.gz from Github.com failed! Try Downloading from SourceForge.net...'
	rm -rf vddos-$latest_version.tar.gz
	curl -L https://sourceforge.net/projects/vddos-protection/files/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz

	originhash=`curl -L https://sourceforge.net/projects/vddos-protection/files/md5sum.txt --silent | grep "vddos-$latest_version.tar.gz" |awk 'NR=1 {print $1}'`
	downloadhash=`md5sum vddos-$latest_version.tar.gz | awk 'NR=1 {print $1}'`
	if [ "$originhash" != "$downloadhash" ]; then
		echo 'Download vddos-'$latest_version'.tar.gz from SourceForge.net failed! Try Downloading from Files.voduy.com...'
		rm -rf vddos-$latest_version.tar.gz
		curl -L https://files.voduy.com/vDDoS-Proxy-Protection/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz
	fi

fi

tar -xvf vddos-$latest_version.tar.gz >/dev/null 2>&1
cd vddos-$latest_version
chmod 755 -R *.sh  >/dev/null 2>&1
chmod 755 -R */*.sh  >/dev/null 2>&1
./install.sh

if [ -f /vddos/vddos ]; then

	curl -L https://github.com/duy13/vDDoS-Layer4-Mapping/raw/master/vddos-layer4-mapping -o /usr/bin/vddos-layer4
	chmod 700 /usr/bin/vddos-layer4

	echo 'Install vDDoS Proxy Protection Done!'

	/root/.acme.sh/acme.sh --set-default-ca  --server  letsencrypt >/dev/null 2>&1
	exit 0
else
	echo 'Install vDDoS Proxy Protection Failed!'
	exit 1
fi