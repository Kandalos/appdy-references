
# How to Install Java Application Agent on Linux Server (Ubuntu)

## Install Java Agent (STANDARD)

### Prequisites:
  - Make sure your application server can communicate with controller and the database by opening the ports 8090 and 1433 (could be varied)

### 1. Unzip and Copy
Unzip the app agent content and copy all the agent files to `/opt/appdynamics/appagent`.
You can use **WinSCP** or a simple **SCP** command to move the file to your server:
`scp source user@host:target`

### 2. Configure .xml file
* **Find Access key:** Go to `host:8090/controller` and find it in your account settings.
* **File Location:** `/conf/controller-info.xml`

**Example Configuration:**
```xml
<controller-host>192.168.1.121</controller-host>
<controller-port>8090</controller-port>
<controller-ssl-enabled>false</controller-ssl-enabled>
<use-simple-hostname>false</use-simple-hostname>
<application-name>ParaBank</application-name>
<tier-name>InventoryTier</tier-name>
<node-name>Inventory1</node-name>

```

### 3. Integrate with App

Run `javaagent.jar` inside the `catalina.sh` or `startup.sh` of your app using this command:
`JAVA_OPTS -javaagent:/opt/appdynamics/appagent/javaagent.jar`

> **NOTE:** It’s better to make a separate `setenv.sh` file and call this file in application startup.

### 4. Controller Setup

Go to the controller GUI and create a new app using the setup wizard.

### 5. Generate Load

Generate load by opening new tabs and refreshing them (**Shift to select all and F5 to refresh**) and wait for the app to connect.

---

## Troubleshoot (Standard)

* If java agent could not connect to controller, check if your app started after the agent or restart your app.
* Check if you have set the correct values in `controller-info.xml`.

---

## Install Java Agent (Docker)

### 1. Unzip and Copy

Unzip the app agent content and copy all the agent files to `/opt/appagent`.
Again, use **WinSCP** or **SCP** to move the files:
`scp source user@host:target`

### 2. Check Images

Check for docker images available on your machine:
`docker image ls`

### 3. Create Docker Image

Create the docker image file for your app and appagent:
`docker image build -t name:latest .`

**Example Dockerfile:**

```dockerfile
FROM my-tomcat9-image
COPY appagent /opt/appagent
COPY parabank /usr/local/tomcat/webapps/ROOT
EXPOSE 8080

```

### 4. Create Environment Variable File

Create a `.env` file for your appagent:

```bash
JAVA_OPTS="-javaagent:/opt/appagent/javaagent.jar"
APPDYNAMICS_AGENT_APPLICATION_NAME=ParaBank2
APPDYNAMICS_AGENT_NODE_NAME=node1
APPDYNAMICS_AGENT_TIER_NAME=tier
APPDYNAMICS_AGENT_ACCOUNT_NAME=customer1
APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=3dc71574-62fd-48ac-bdea-20dc6cc70b9e
APPDYNAMICS_CONTROLLER_HOST_NAME=192.168.1.121
APPDYNAMICS_CONTROLLER_PORT=8090
#APPDYNAMICS_JAVA_AGENT_REUSE_NODE_NAME=true
#APPDYNAMICS_JAVA_AGENT_REUSE_NODE_NAME_PREFIX=node

```

### 5. Run the Container

Check for docker images again and run the container for your app:
`docker container run -d --name parabank2 --publish 8080:8080 --env-file .env parabank`

---

## Troubleshoot (Docker)

* To see docker container logs use: `docker logs <container_name>`
* To check for docker logs itself use: `journalctl -xu docker.service`
* You should check if you have correct values in your environment variables.

---
