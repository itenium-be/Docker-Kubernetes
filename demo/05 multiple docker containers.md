# 05 Docker multiple containers

## Exercise

**Replace 159.65.192.158 with the IP address of your cloud machine**

* we are going to run a `demo` application composed of

  * a database (will be a MongoDB container)
  * a backend (will be container containing a REST API made in .NET Core that interrogates the MongoDB)
  * a frontend (will be a container containing an NGINX webserver that hosts an Angular application)

* the database container

  * will be instantiated from the image `mongo`
  * will need to map the container folder `/data/db` to a volume called `mongodata`
  * will need to map the container folder `/data/configdb` to a volume called `mongoconfig`
  * will need to be named `demo.db`

* the backend container

  * will be instantiated from the image `jeankedotcom/demo-backend:v1.1`
  * will need to link to the database container
  * the backend container expects the MongoDB server to be named `demo-db-mongodb`
  * hosts the REST API internally on port `80`
  * needs to expose the REST API on the docker host machine on port `5011`
  * will need to be named `demo.api`

* the frontend container

  * will be instantiated from the image `jeankedotcom/demo-frontend:v2.1`
  * will need an environment variable called `REST_API_URL` pointing to the base url of the REST API
  * hosts the Angular application internally on port `80`
  * needs to expose the Angular application on the docker host machine on port `5010`

* you can test if the application is runnig

  * by checking if all containers are running (if not, you can inspect the logs of non-running containers)
  * by going to the testpage of the REST API on <http://159.65.192.158:5011> (the base url)
  * by going to the Angular application on <http://159.65.192.158:5010>
