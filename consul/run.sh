#!/bin/bash
#
# If you want to use a different token, run these two commands in an already running consul:
#
#
#   1)  commands="consul acl bootstrap 2>&1 | awk '{print $ NF}' | sed s/[^0-9]//g  > /consul/data/acl-bootstrap-reset && consul acl bootstrap"
#
#   2)  docker exec -it -e script="$commands" consul sh -c 'echo $script > /tmp/script.sh; chmod +x /tmp/script.sh; sh /tmp/script.sh'
#
#
# Then set the new environment value "TOKEN" in this file from the new SecretID value you got after running the commands above.
#
#---------------------------------------------------
TOKEN=d9828ae7-07c7-1c8a-de40-7152ee3964c2
#---------------------------------------------------
#
# And then execute ./run.sh
#
#---------------------------------------------------
version=1.11
#---------------------------------------------------


docker volume create consul-data > /dev/null 2>&1

echo '{"datacenter":"dc1","primary_datacenter":"dc1","server":true,"data_dir":"/consul/data","log_level":"INFO","node_name":"consul","client_addr":"0.0.0.0","ui_config":{"enabled":true},"telemetry":{"disable_compat_1.9":true},"acl":{"enabled":true,"default_policy":"deny","enable_token_persistence":true,"tokens":{"initial_management":"$TOKEN","agent":"$TOKEN"},"down_policy":"extend-cache"}}' | sed 's/$TOKEN/'$TOKEN'/g'> /tmp/consul-config.json

docker run -d --name consul -p 80:8500 -v consul-data:/consul/data -e CONSUL_LOCAL_CONFIG=$(cat /tmp/consul-config.json) -e CONSUL_HTTP_ADDR=127.0.0.1:8500 -e CONSUL_HTTP_TOKEN=$TOKEN consul:$version agent -server -bootstrap-expect=1 > /dev/null 2>&1

sleep 10

echo

docker ps | grep consul > /dev/null 2>&1 || docker logs consul

echo

docker ps -a --filter "status=exited" | grep consul > /dev/null 2>&1 && echo && echo "Container with Consul was deleted, because he is not started" && docker rm -f consul > /dev/null 2>&1 && docker volume rm -f consul-data > /dev/null 2>&1 && echo

docker ps | grep consul > /dev/null 2>&1 && echo && echo "Succesfully =)" && echo && echo "Go to link --> http://localhost and use this token --> $TOKEN <-- for authorization" && echo && echo && sleep 5 && docker exec -it consul consul members && echo && docker exec -it consul consul operator raft list-peers

rm -rf /tmp/consul-config.json
