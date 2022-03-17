#!/bin/bash

echo '{"datacenter":"dc1","primary_datacenter":"dc1","server":true,"bootstrap_expect":1,"data_dir":"/consul/data","log_level":"INFO","node_name":"consul","client_addr":"0.0.0.0","ui":true,"telemetry":{"disable_compat_1.9":true},"acl":{"enabled":true,"default_policy":"deny","enable_token_persistence":true,"tokens":{"initial_management":"725e5217-9412-5da0-b5d5-f60afc02cac8"},"down_policy":"extend-cache"}}' > ./config.json

docker run -d --name consul -p 80:8500 -e CONSUL_LOCAL_CONFIG=$(cat ./config.json) -e CONSUL_HTTP_ADDR=127.0.0.1:8500 -e CONSUL_HTTP_TOKEN=725e5217-9412-5da0-b5d5-f60afc02cac8 consul:1.11

sleep 3

echo

docker ps | grep consul || docker logs consul 

echo

docker ps -a --filter "status=exited" | grep consul && echo && echo "Deleted container with Consul, because he is not started" && docker rm -f consul > /dev/null 2>&1 && echo

rm -rf ./config.json
