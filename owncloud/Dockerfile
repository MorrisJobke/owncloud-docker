FROM mmckeen/owncloud:latest
MAINTAINER hey@morrisjobke.de

RUN zypper -n in patch

ADD sqlite.patch /
RUN cd /srv/www/htdocs/owncloud && patch -p1 < /sqlite.patch
