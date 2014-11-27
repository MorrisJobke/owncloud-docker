# ownCloud docker container - auto setup

This creates a ownCloud instance that is setup automatically by just linking a appropiate DB against the docker container. Currently only MySQL and PostgreSQL docker container are detected (called mysql and postgres on docker hub). If none is detect the ownCloud instance uses SQLite. There is also a patch included that speeds up ownCloud with SQLite.

You can also set ADMINLOGIN, ADMINPWD and DATABASENAME as environment variables to adjust these data of the ownCloud instance.
