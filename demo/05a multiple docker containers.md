# 05a Docker multiple containers

## Solution

```shell
docker volume create mongodata
docker volume create mongoconfig
docker run -d --name demo.db -v mongodata:/data/db -v mongoconfig:/data/configdb mongo
docker run -d --name demo.api --link demo.db:demo-db-mongodb -p 5011:80 jeankedotcom/demo-backend:v1.1
docker run -d --name demo.frontend -p 5010:80 -e REST_API_URL=http://159.65.192.158:5011 jeankedotcom/demo-frontend:v2.1
```

* this solution is valid but needs a lot of commandline knowledge
* it would be easier to have a configuration file that contains all of the container setup: `docker-compose.yaml`

```shell
cd compose
docker-compose up -d
```

* check the logs

```shell
docker-compose logs
```

* check <http://159.65.192.158:5010>

* remove the application

```shell
docker-compose down
```

* check the volumes

```shell
docker volume ls
```

* remove all volumes

```shell
docker volume rm $(docker volume ls -q)
```

* recheck the volumes

```shell
docker volume ls
```
