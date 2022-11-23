# 01 Docker intro

## Follow along

**Make sure to replace 159.65.192.158 with the IP address of your cloud machine (see personal Teams message)**

* list all docker images on your cloud machine

```shell
docker image list

# filtered on repository with name "nginx"
docker image list nginx
```

* pull an image from the "Docker Hub" registry to your cloud machine (see <https://hub.docker.com/_/nginx/>)

```shell
docker pull nginx
```

* list the image on your cloud machine

```shell
docker image list nginx
```

* list all docker containers on your cloud machine

```shell
docker container list --all
```

* run a container on your cloud machine and expose port 80 of the container to port 5000 on your cloud machine

```shell
docker run -p 5000:80 nginx
```

* surf to <http://159.65.192.158:5000>
* you will see the container logs to the console
* press `Ctrl+C` to stop the console running
* the container stopped
  * refresh browser
  * list all running containers
* logs can still be consulted

```shell
docker logs <CONTAINERID_OR_CONTAINERNAME>
```

* get all the details

```shell
docker container inspect <CONTAINERID_OR_CONTAINERNAME>
```

* start container again

```shell
docker container start <CONTAINERID_OR_CONTAINERNAME>
```

* surf to <http://159.65.192.158:5000> (should work again)

* try to remove the container

```shell
docker container rm <CONTAINERID_OR_CONTAINERNAME>
```

* did not work since it's running, so stop the container

```shell
docker container stop <CONTAINERID_OR_CONTAINERNAME>
```

* list all docker containers

```shell
docker container list --all
```

* remove the container

```shell
docker container rm <CONTAINERID_OR_CONTAINERNAME>
```

* surf again to <http://159.65.192.158:5000>
* run the same container
  * with the latest version
  * as a daemon
  * with a significant name

```shell
docker run -p 5000:80 --name nginx -d nginx:1.23.1
```

* run a container on the same machine
  * with the previous nginx version
  * on a different port
  * with a different name

```shell
docker run -p 5001:80 --name nginx-prev -d nginx:1.22.0
```

* list both images on your cloud machine

```shell
docker image list
```

* list both docker containers on your cloud machine

```shell
docker container list --all
```

* surf to <http://159.65.192.158:5000>
* and surf to <http://159.65.192.158:5001>
* an follow the logs of both containers in different consoles

```shell
docker logs -f nginx
```

```shell
docker logs -f nginx-prev
```

* shortest way to shut down and remove all containers...
* display all container ids

```shell
docker container list -aq
```

* and feed the ids to a forces docker remove command

```shell
docker container rm --force $(docker container list -aq)
```

* list all containers again

```shell
docker container list --all
```
