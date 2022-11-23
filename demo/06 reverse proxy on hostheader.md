# 06 Docker reverse proxy on hostheader

```shell
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy

docker volume create mongodata
docker volume create mongoconfig
docker run -d --name demo.db -v mongodata:/data/db -v mongoconfig:/data/configdb mongo
docker run -d --name demo.api --link demo.db:demo-db-mongodb -e VIRTUAL_HOST=api.itenium-training.be jeankedotcom/demo-backend:v1.1
docker run -d --name demo.frontend  -e VIRTUAL_HOST=app.itenium-training.be -e REST_API_URL=http://api.itenium-training.be jeankedotcom/demo-frontend:v2.1
```

* open `C:\Windows\System32\drivers\etc\hosts` in Notepad running as Administator
* add lines

```shell
	159.65.192.158       api.itenium-training.be
	159.65.192.158       app.itenium-training.be
```

* save it
* check <http://app.itenium-training.be>

## Exercise

* Modify the docker-compose.yaml file to use nginx-proxy and the hostheaders
