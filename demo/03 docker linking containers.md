# 03 Docker linking containers

## Demo

* run a sql server 2022 container, see <https://hub.docker.com/_/microsoft-mssql-server>

```shell
docker run --name sqlserver2022 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=itenium' -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2022-latest
```

* link the sqlpad container to the sql server

```shell
docker run --name sqlpad --link sqlserver2022:sqlserver -e 'SQLPAD_ADMIN=jan.wielemans@devgem.be'  -e 'SQLPAD_ADMIN_PASSWORD=Test123!' -d -p 3000:3000 sqlpad/sqlpad
```

* check out the containers

```shell
docker container list -a
```

* check why sql server did not start

```shell
docker logs sqlserver2022
```

* remove the the containers and recreate them properly

```shell
docker container rm -f $(docker container list -aq)
docker run --name sqlserver2022 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Itenium_1234' -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2022-latest
docker run --name sqlpad --link sqlserver2022:sqlserver -e 'SQLPAD_ADMIN=jan.wielemans@devgem.be'  -e 'SQLPAD_ADMIN_PASSWORD=Test123!' -d -p 3000:3000 sqlpad/sqlpad
```

* check out the containers

```shell
docker container list -a
docker container inspect <CONTAINERID_OR_CONTAINERNAME>
```

* check out the sqlpad site on <http://159.65.192.158:3000>
* create a connection to the sqlserver container
* do a query

```sql
SELECT * FROM master.sys.databases;
```

* create a database

```sql
CREATE DATABASE itenium;
```

* check databases again

```sql
SELECT * FROM master.sys.databases;
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

* recreate the sql server 2022 container

```shell
docker run --name sqlserver2022 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Itenium_1234' -e 'MSSQL_PID=Express' -d mcr.microsoft.com/mssql/server:2022-latest
```

* do a query

```sql
SELECT * FROM master.sys.databases;
```
