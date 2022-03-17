#!/bin/bash
#
# If you want to use a different token, run this command in an already running consul:
#
# docker exec --rm -it consul:1.11 consul acl bootstrap
#
# Set the new environment value "TOKEN" in this file from the new SecretID value you got after running the command above. 
#
#---------------------------------------------------
TOKEN=725e5217-9412-5da0-b5d5-f60afc02cac8
#---------------------------------------------------
#
# And then execute ./run.sh
#
#---------------------------------------------------
version=1.11
#---------------------------------------------------


echo '{"datacenter":"dc1","primary_datacenter":"dc1","server":true,"data_dir":"/consul/data","log_level":"INFO","node_name":"consul","client_addr":"0.0.0.0","ui_config":{"enabled":true},"telemetry":{"disable_compat_1.9":true},"acl":{"enabled":true,"default_policy":"deny","enable_token_persistence":true,"tokens":{"initial_management":"$TOKEN","agent":"$TOKEN"},"down_policy":"extend-cache"}}' | sed 's/$TOKEN/'$TOKEN'/g'> /tmp/consul-config.json

docker run -d --name consul -p 80:8500 -e CONSUL_LOCAL_CONFIG=$(cat /tmp/consul-config.json) -e CONSUL_HTTP_ADDR=127.0.0.1:8500 -e CONSUL_HTTP_TOKEN=$TOKEN consul:$version agent -server -bootstrap-expect=1 > /dev/null 2>&1

sleep 10

echo

docker ps | grep consul > /dev/null 2>&1 || docker logs consul 

echo

docker ps -a --filter "status=exited" | grep consul > /dev/null 2>&1 && echo && echo "Container with Consul was deleted, because he is not started" && docker rm -f consul > /dev/null 2>&1 && echo

docker ps | grep consul > /dev/null 2>&1 && echo && echo "Succesfully =)" && echo && echo "Go to link --> http://localhost and use this token --> $TOKEN <-- for authorization" && echo && echo && sleep 5 && docker exec -it consul consul members && echo && docker exec -it consul consul operator raft list-peers

rm -rf /tmp/consul-config.json
