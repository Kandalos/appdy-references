
## **AppDynamics Events Service Installation Guide**

### **1. Virtual Machine Preparation**

Ensure your host meets the following minimum specifications for a stable installation:

* **CPU:** 4 Cores (Minimum)
* **RAM:** 16GB – 32GB (32GB recommended for production)
* **Storage:** 1TB SSD (Minimum 100GB for lab/testing)
* **OS:** Ubuntu (18.x, 20.x, or 22.x)

### **2. Network & Firewall Configuration**

The Enterprise Console and Controller must communicate with the Events Service via port **9080**.

```bash
# Allow the REST API port
sudo ufw allow 9080/tcp

# Allow the Admin port (Required for cluster management)
sudo ufw allow 9081/tcp

# Reload firewall to apply changes
sudo ufw reload

```

### **3. System Synchronization**

Time drift between the Controller and Events Service will cause data ingestion failures.

```bash
sudo timedatectl set-timezone America/New_York

```

### **4. SSH Credential Setup (Passwordless SSH)**

The Enterprise Console uses SSH keys to remotely manage and deploy the Events Service.

**On the Enterprise Console Server:**

```bash
# Create and secure the .ssh directory
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cd ~/.ssh

# Generate a 2048-bit RSA key in PEM format
ssh-keygen -t rsa -b 2048 -v -m pem -f appd-ssh

# Copy the public key to your Events Service host
scp ~/.ssh/appd-ssh.pub user@events-service-host:~/

```

### **5. Directory & Permission Setup**

AppDynamics requires a dedicated directory with proper ownership.

```bash
# Create the installation directory
sudo mkdir -p /opt/appdynamics

# Grant ownership to the appdynamics service user (e.g., 'appdy')
sudo chown -R appdy:appdy /opt/appdynamics

```

### **6. Deployment via Enterprise Console**

1. **Add Credential:** In the Enterprise Console UI, add a new SSH credential. Use the content of the private key located on the Controller host:
```bash
cat ~/.ssh/appd-ssh

```


2. **Add Host:** Add the Events Service host IP/Hostname using the credential created above.
3. **Install:** Use the **Custom Install** (or Express for single-node) in the Enterprise Console to deploy the Events Service.

---

## **Troubleshooting (Official Reference)**

### **Critical: Linux User Limits**

The Events Service (Elasticsearch) will fail if file descriptors are too low. Add these to `/etc/security/limits.conf`:

```text
* hard nofile 65535
* soft nofile 65535
* hard nproc 65535
* soft nproc 65535

```

### **Installation Failures**

* **Permission Denied:** Ensure the user specified in the Enterprise Console has `sudo` privileges or full ownership of `/opt/appdynamics`.
* *Fix:* `sudo chown -R user:user /opt/appdynamics`


* **Noexec Mount Error:** If your `/tmp` directory is mounted with the `noexec` option, the installer will fail.
* *Fix:* Remount with exec: `sudo mount -o remount,exec /tmp`


* **Connection Refused:** Verify that you can manually SSH from the Enterprise Console to the Events Service host using `ssh -i ~/.ssh/appd-ssh user@host`.

### **Operational Issues**

* **Java Version:** Events Service 23.x+ requires **Java 17**. Check your version:
```bash
java -version

```


* **Disk Space Check:** Elasticsearch will lock the indices if disk space drops below **15%**. Ensure you have at least 128GB free for logs and data.
* **Clock Skew:** If events aren't appearing, verify that `timedatectl status` shows identical times on both the Controller and Events Service nodes.
