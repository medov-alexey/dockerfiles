# Bash script for run simple single instance Consul by HashiCorp in Docker container.

# This is not a Consul Cluster. Only one node.

#-----------------------------------------------------------------------------------

# For run Consul use this command:

./run.sh

# or this command

$(pwd)/run.sh

#-----------------------------------------------------------------------------------

# For delete Consul container use this command:

docker rm -f consul
