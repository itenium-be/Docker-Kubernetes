# 04 Docker volumes

## Demo

* on-disk files in a container are ephemeral...

* stop and remove the sql server 2022 container again

```shell
docker container rm --force sqlserver2022
```

* check all volumes

```shell
docker volume ls
```

* create a docker volume

```shell
docker volume create sqlserver
```

* run a sql server 2022 container with volumes

```shell
docker run --name sqlserver2022 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Itenium_1234' -e 'MSSQL_PID=Express' -d -v sqlserver:/var/opt/mssql mcr.microsoft.com/mssql/server:2022-latest
```

* check out the containers

```shell
docker container list -a
```

* check out the sqlpad site on <http://159.65.192.158:3000>
* do a query

```sql
SELECT * FROM master.sys.databases;
```

* create a database

```sql
CREATE DATABASE itenium;
```

* create a table with some data

```sql
USE itenium;
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255)
);
INSERT INTO Persons (PersonID, LastName, FirstName)
VALUES
    (1, 'Bill', 'Gates'),
    (2, 'Steve', 'Jobs'),
    (3, 'Elon', 'Musk'),
    (4, 'Jeff', 'Bezos'),
    (5, 'Gavin', 'Belson');
```

* query the table

```sql
USE itenium;
SELECT * FROM Persons;
```

* stop and remove the sql server 2022 container

```shell
docker container rm --force sqlserver2022
```

* recreate the sql server 2022 container with the volumes

```shell
docker run --name sqlserver2022 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=GocItenium_1234' -e 'MSSQL_PID=Express' -d -v sqlserver:/var/opt/mssql mcr.microsoft.com/mssql/server:2022-latest
```

* do a query

```sql
USE itenium;
SELECT * FROM Persons;
```

* backup and/or restore the volume, see <https://blog.ssdnodes.com/blog/docker-backup-volumes/>

* delete all containers and volumes

```shell
docker container rm --force $(docker container list -aq)
docker volume rm sqlserver
```
