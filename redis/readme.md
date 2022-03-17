<b> Command example for run docker container with image medoff/redis:6-alpine </b>

docker run -d --name redis-server -e memory_size=1024 -e password=12345678 medoff/redis:6-alpine

<br></br>

<b> Supported two environment params: </b>

memory_size - memory limit for redis-server in megabytes

password - password for connect to redis-server


