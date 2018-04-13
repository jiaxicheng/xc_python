*Notes:*
1. Scripts under the folder /docker-entrypoint-initdb.d only works when initializing the container.
   After any data exist in MySQL $DATADIR(i.e. /var/lib/mysql), none of these scripts will be executed.
   Below lists the valid file extensions and how the file will be processed:
```
  + file.sh     --> $ source file.sh
  + file.sql    --> $ mysql < file.sql
  + file.sql.gz --> $ zcat file.sql.gz | mysql
```
2. To import data saved in `*.sql.gz`, make sure they were dumped with database name (use '-B' flag),
   i.e.
```
  mysqldump -B mydbname | gzip > mydbname.sql.gz
```
3. Scripts under this folder are executed in alphabetic order, so do name them properly, i.e. adding
   `01_`, `02_` prefix to make sure their execution order.


