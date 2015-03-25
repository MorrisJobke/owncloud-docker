FROM mmckeen/owncloud:latest
MAINTAINER hey@morrisjobke.de

RUN zypper -n in php5-pgsql owncloud-app-provisioning_api

ADD run.sh /

CMD /run.sh
