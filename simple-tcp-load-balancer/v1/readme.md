<h1>This is simple round-robin tcp load balancer based on nginx</h1>

<b>Commands examples for use image medoff/simple-tcp-load-balancer:v1</b>

Example 1:

docker run -d --name simple-tcp-load-balancer -e port=500 -e server1=172.16.1.11:8000 -e server2=172.16.1.12:9000 medoff/simple-tcp-load-balancer:v1

Example 2:

docker run -d --name tcp-balancer -e port=80 -e server1=192.168.1.220:80 -e server2=192.168.1.230:80 -e server3=192.168.1.240:80 medoff/simple-tcp-load-balancer:v1

<b>Supported two environment params:</b>

*port* - port number for listen on load-balancer

*server* - backend server ip address and port

<b>Maximum 5 backend servers supported</b>

*server1, server2, server3, server4, server5*

<b>Config in v1 image</b>

*proxy_connect_timeout 60s;*

*proxy_timeout 300s;*

*proxy_buffer_size 512k;*
