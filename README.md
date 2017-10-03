<div alt="vDDoS Proxy Protection Logo" class="separator" style="clear: both; text-align: center;">
<a href="https://lh4.googleusercontent.com/-eTeYLP6S_58/WRb97Hrfv9I/AAAAAAAABgs/kxmdPf-hLngVPtg9InzvdKkihBkVv-6WwCLcB/s1600/vDDoS-Proxy-Protection-Icon-Logo-voduy.com-5.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img align="right" border="0" src="https://lh4.googleusercontent.com/-eTeYLP6S_58/WRb97Hrfv9I/AAAAAAAABgs/kxmdPf-hLngVPtg9InzvdKkihBkVv-6WwCLcB/s222/vDDoS-Proxy-Protection-Icon-Logo-voduy.com-5.png" /></a></div>

vDDoS Proxy Protection
===================


Welcome to vDDoS, a HTTP(S) DDoS Protection Reverse Proxy. Thank you for using!

Homepage: http://vddos.voduy.com

----------


System Requirement
-------------

* CentOS Server 5/6/7 x86_64 (http://centos.org)
* CloudLinux Server 5/6/7 x86_64 (http://cloudlinux.com)
```
yum -y install epel-release 
yum -y install curl wget gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed gcc automake autoconf apr-util-devel gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed 

```

----------
Install
-------------

Example Install: System CentOS 7 x86_64 & vDDoS 1.13.3 Version (vddos-1.13.3-centos7):
```
curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-1.13.3-centos7 -o /usr/bin/vddos
chmod 700 /usr/bin/vddos
/usr/bin/vddos help

/usr/bin/vddos setup
```

----------
Using
-------------
Example Edit website.conf:

```
# nano /vddos/conf.d/website.conf

# Website       Listen               Backend                  Cache Security SSL-Prikey   SSL-CRTkey
default         http://0.0.0.0:80    http://127.0.0.1:8080    no    200      no           no
your-domain.com http://0.0.0.0:80    http://127.0.0.1:8080    no    200      no           no
default         https://0.0.0.0:443  https://127.0.0.1:8443   no    307      /vddos/ssl/your-domain.com.pri /vddos/ssl/your-domain.com.crt
your-domain.com https://0.0.0.0:443  https://127.0.0.1:8443   no    307      /vddos/ssl/your-domain.com.pri /vddos/ssl/your-domain.com.crt
your-domain.com https://0.0.0.0:4343 https://103.28.249.200:443 yes click    /vddos/ssl/your-domain.com.pri /vddos/ssl/your-domain.com.crt

```
Save config website.conf

Restart vDDoS:
```
vddos restart
```

----------
Explain Config:
-------------
```
nano /vddos/conf.d/website.conf
```
Website:
---------------
**variable:** *default, your-domain.com, www.your-domain.com*

Sets domain name listen.
Note: only one default on one port listen
Example:
```
# Website       Listen               Backend                  Cache Security SSL-Prikey   SSL-CRTkey
default         http://0.0.0.0:80    http://127.0.0.1:8080    no    200      no           no
default         https://0.0.0.0:443  https://127.0.0.1:8443   no    200      /vddos/ssl/your-domain.com.pri /vddos/ssl/your-domain.com.crt
```
Listen:
---------------
**variable:** *http://0.0.0.0:80, https://0.0.0.0:443, http://123.234.012.321:80*

Sets IP & Port listen.

Backend:
---------------
**variable:** *http://123.234.012.321:80, https://123.234.012.321:443, http://127.0.0.1:8080*

Sets Real IP & Port Backend Service.

Cache:
---------------
**variable:** *no, yes*

Sets proxy cache website on vDDoS.

Security:
---------------
**variable:** *no, 307, 200, click, 5s, high, captcha*

Sets a valid for Security Level Protection.
Note: no < 307 < 200 < click < 5s < high < captcha

SSL-Prikey:
---------------
**variable:** */location/ssl/key/of/your/private/key/privkey.pem*

Sets SSL Private key website for vDDoS.
Note: Option need for HTTPS Listen.

SSL-CRTkey:
---------------
**variable:** */location/ssl/key/of/your/public/key/cert.pem*

Sets SSL Public key website for vDDoS.
Note: Option need for HTTPS Listen.


More Config:
---------------
Document: http://vddos.voduy.com
```
Still in beta, use at your own risk! It is provided without any warranty!
```

