#!/bin/bash

# Check if the number of nodes is passed as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 NUMBER_OF_NODES"
    exit 1
fi

NUMBER_OF_NODES=$1

# Debug function
debug_message() {
  echo "[DEBUG] $1"
}

# Create the Jenkins master node
debug_message "Creating Jenkins master node..."
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-master --hostname jenkins-master jenkins/jenkins:lts
debug_message "Jenkins master node created."

# Wait for the Jenkins master to start up
debug_message "Waiting for Jenkins master to start up..."
sleep 30

# Get the initial admin password
debug_message "Getting initial admin password..."
initial_admin_password=$(docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword)
echo "Initial admin password: $initial_admin_password"

# Create the Jenkins nodes
for i in $(seq 1 $NUMBER_OF_NODES); do
  node_name="jenkins-node-$i"
  debug_message "Creating Jenkins node $i..."
  docker run -itd --name "$node_name" --hostname "$node_name" jenkins/inbound-agent
  debug_message "Jenkins node $i created."
done

# Exit if any command fails
set -e

debug_message "Script completed successfully."
