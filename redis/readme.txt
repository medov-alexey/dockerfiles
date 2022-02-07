# Command example for use image medoff/redis:6-alpine

docker run -d --name redis-server -e memory_size=1024 -e password=12345678 medoff/redis:6-alpine




# Supported two environment params:

memory_size - memory limit for redis-server
password - password for connect to redis-server
