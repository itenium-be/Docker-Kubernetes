# 02 Docker create image

## Demo container

* run an nginx container

```shell
docker run -d --name nginx -p 5000:80 nginx:1.23.1
```

* bash into it

```shell
docker exec -it nginx bash
```

* check out the filesystem inside the docker container

```shell
ls
cd /usr/share/nginx/html
ls
cat index.html
```

* leave the container

```shell
exit
```

* check out the default page <http://159.65.192.158:5000>
* open the root folder in VSCode
* create a new `index.html` file in a local `my-app` folder

```html
<html>
    <head>
        <title>Hello</title>
    </head>
    <body>
        <h1>Hello from my app!</h1>
        <h2>at the Itenium training</h2>
    </body>
</html>
```

* copy it to the container

```shell
docker cp my-app/index.html nginx:/usr/share/nginx/html
```

* check out the new page <http://159.65.192.158:5000>
* commit the container to an new image

```shell
docker commit nginx  devgem/my-app:1.0
```

* check the images

```shell
docker image list
```

* remove all containers

```shell
docker container rm --force $(docker container list -aq)
```

* start an old container on 5000 and a new one one 5001

```shell
docker run -d --name nginx -p 5000:80 nginx:1.23.1
docker run -d --name my-app -p 5001:80 devgem/my-app:1.0
```

* check the pages on <http://159.65.192.158:5000> and <http://159.65.192.158:5001>
* show devgem account in Docker Hub (login jeankedotcom) <https://hub.docker.com/r/devgem/my-app>
* push the image to Docker Hub
* watch it fail
* login to docker and watch it succeed

```shell
docker push devgem/my-app:1.0
docker login
docker push devgem/my-app:1.0
```

* show the pushed image and tags on Docker Hub
* update the message in `index.html` to show `version 2.0`
* create a docker image as you should with the `v2.Dockerfile`

```shell
cd my-app
docker build -f v2.Dockerfile -t devgem/my-app:2.0 .
```

* run the new container on port 5002 with a different name

```shell
docker run -d --name my-app2 -p 5002:80 devgem/my-app:2.0
```

* show it <http://159.65.192.158:5002>
* show the labels

```shell
docker inspect my-app2
#search for labels
```

* push the image

docker push devgem/my-app:2.0

## Follow along app2

* run the new container on your cloud machine

```shell
docker run -d --name my-app2 -p 5002:80 devgem/my-app:2.0
```

## Demo container variables

* add a variable MY_MESSAGE to `index.html` for `version 3`
* check out `env-setup.sh`
* append to `v3.DockerFile`

```shell
COPY env-setup.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/env-setup.sh

CMD ["/usr/local/bin/env-setup.sh"]
```

* build version 3.0
* make sure you are in the `my-app` folder

```shell
docker build -f v3.Dockerfile -t devgem/my-app:3.0 .
```

* run version 3.0 on your cloud machine with yet another name on yet another poer

```shell
docker run -d --name my-app3 -p 5003:80 -e my_message="Hello from Itenium" devgem/my-app:3.0
```

* check <http://159.65.192.158:5003/>
* run another with another message

```shell
docker run -d --name my-app4 -p 5004:80 -e my_message="Hi from Sint-Agathe-Berchem!" devgem/my-app:3.0
```
* check <http://159.65.192.158:5004/>

* push the new image

```shell
docker push devgem/my-app:3.0
```

## Follow along with container variables

* run the new container with environment variable on your cloud machine

```shell
docker run -d --name my-app4 -p 5004:80 -e my_message="Whatever message you want" devgem/my-app:3.0
```

* check the details of the container

```shell
docker container inspect <CONTAINERID_OR_CONTAINERNAME>
```
