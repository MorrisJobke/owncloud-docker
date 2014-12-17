FROM mmckeen/owncloud:latest
MAINTAINER hey@morrisjobke.de

RUN zypper -n in patch php5-pgsql

ADD sqlite.patch /
RUN cd /srv/www/htdocs/owncloud && patch -p1 < /sqlite.patch
ADD webdav-mimetype.patch /
RUN cd /srv/www/htdocs/owncloud && patch -p1 < /webdav-mimetype.patch

ADD run.sh /

CMD /run.sh
