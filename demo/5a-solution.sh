docker volume create mongodata
docker volume create mongoconfig
docker run -d --name demo.db -v mongodata:/data/db -v mongoconfig:/data/configdb mongo
docker run -d --name demo.api --link demo.db:demo-db-mongodb -p 5011:80 jeankedotcom/demo-backend:v1.1
docker run -d --name demo.frontend -p 5010:80 -e REST_API_URL=http://159.65.192.158:5011 jeankedotcom/demo-frontend:v2.1
