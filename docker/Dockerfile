FROM centos:7

RUN yum -y update && yum clean all
RUN yum -y install epel-release
RUN yum -y install curl wget gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed gcc automake autoconf apr-util-devel gc gcc gcc-c++ pcre-devel zlib-devel make wget openssl openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools gperftools-devel libatomic_ops-devel perl-ExtUtils-Embed

RUN curl -L https://github.com/duy13/vDDoS-Protection/raw/master/latest.sh -o latest.sh \
  && chmod 700 latest.sh \
  && bash latest.sh

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["usr/local/bin/docker-entrypoint.sh"]
CMD ["vddos"]
