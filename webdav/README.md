# WebDAV container

You can run this container in following way. You can then access the WebDAV instance at `http://localhost:8888/webdav`. Internally the folder `/var/webdav` is used as WebDAV root.

```
docker run -d -e USERNAME=test -e PASSWORD=test -p 8888:80 morrisjobke/webdav
```
