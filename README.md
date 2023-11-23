# Jenkins Docker Setup

## Table of Contents

1. [Description](#description)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Adding Nodes to Jenkins](#adding-nodes-to-jenkins)
5. [Usage Verification](#usage-verification)
6. [License](#license)
7. [Contact](#contact)

## Description

This repository contains a Bash script for setting up a Jenkins environment with a master node and a user-defined number of agent nodes, all running as Docker containers.

## Prerequisites

- Docker: You need to have Docker installed on your machine to run the containers.
- Jenkins: The script sets up a Jenkins environment, so you need to have Jenkins installed on your machine.

## Installation

1. Clone the repository to your local machine.
2. Navigate to the directory containing the script.
3. Run the script with the number of nodes as an argument.

## Adding Nodes to Jenkins

After running the script, you need to manually add the nodes to Jenkins:

1. **Access Jenkins.** Open a web browser and go to `http://localhost:8080`. You should see the Jenkins welcome page.
2. **Log in as admin.** Use the initial admin password obtained from the script to log in as admin.
3. **Go to the nodes page.** From the main menu, go to "Manage Jenkins" > "Manage Nodes and Clouds".
4. **Add a new node.** Click on "New Node", enter a name for your node (e.g., "jenkins-node-1"), select "Permanent Agent", then click "OK".
5. **Configure the node.** On the node configuration page, enter the following information:
   - **Remote root directory:** A path on your node where Jenkins can create files (e.g., "/home/jenkins").
   - **Labels:** A label for your node (e.g., "jenkins-node").
   - **Usage:** Select "Use this node as much as possible".
   - **Launch method:** Select "Launch agent via execution of command on the master" and enter the command to launch the Jenkins agent on your node. If you are using the `jenkins/inbound-agent` Docker image, the command will be similar to this:
     ```bash
     docker run -d --name jenkins-node-1 --link jenkins-master:jenkins-master jenkins/inbound-agent java -jar /usr/share/jenkins/agent.jar -jnlpUrl http://jenkins-master:8080/computer/jenkins-node-1/jenkins-agent.jnlp -secret <secret> -workDir "/home/jenkins"
     ```
     Replace `<secret>` with the node's secret, which will be available after you save the node's configuration.
6. **Save the node configuration.** Click "Save" to save the node configuration.

## Usage Verification

After running the script, you can verify its success by checking the operation of the nodes and executing a verification ping between the master and agent nodes.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Contact

Gerardo Cipriano
gerardo.cipriano@studio.unibo.it
