FROM centos:centos7

RUN yum -y update \
    && yum -y install epel-release 

ENV WP_VERSION=4.9.7

ADD https://wordpress.org/wordpress-${WP_VERSION}.zip /tmp/${WP_VERSION}.zip
#ADD https://downloads.wordpress.org/plugin/really-simple-ssl.3.0.2.zip /tmp/really-simple-ssl.3.0.2.zip
#ADD https://downloads.wordpress.org/plugin/onelogin-saml-sso.zip /tmp/onelogin-saml-sso.zip
#ADD https://downloads.wordpress.org/plugin/user-role-editor.4.44.zip /tmp/user-role-editor.4.44.zip
#ADD https://downloads.wordpress.org/plugin/wp-private-content-plus.1.23.zip /tmp/wp-private-content-plus.1.23.zip

RUN yum install -y supervisor nginx php-fpm php-cli php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml \
    php-xmlrpc php-magickwand php-magpierss php-mbstring php-mcrypt php-mssql php-shout php-snmp php-soap php-tidy \
    php-apc pwgen python-setuptools git unzip \
    && rm -rf /usr/share/nginx/html/* /var/yum/cache/*

RUN unzip /tmp/${WP_VERSION}.zip \
    && ls -ltr \
    && mv wordpress /usr/share/nginx/html/ \
    && chown -R nginx:nginx /usr/share/nginx/html /var/log/nginx/ \
    && rm -rf /tmp/${WP_VERSION}.zip

ADD configs/nginx.conf /etc/nginx/nginx.conf
ADD configs/wordpress-fpm.conf /etc/php-fpm.d/www.conf
ADD configs/supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
