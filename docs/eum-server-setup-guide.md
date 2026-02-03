## **AppDynamics EUM Server Installation Guide**

### **1. Provisioning & System Requirements**

Ensure your Linux host (Ubuntu) meets these specifications based on your expected traffic:

* **CPU:** 4 Cores (Minimum)
* **RAM:** 8GB – 32GB (16GB+ recommended for production)
* **Storage:** 50GB SSD (Minimum)

### **2. Network & Firewall Configuration**

The EUM server requires several ports for the **Processor**, **Aggregator**, and **Events Service** communication.

```bash
# Ports required: 7001 (HTTP), 7002 (HTTPS), 8090 (Controller Comm)
sudo ufw allow 7001/tcp
sudo ufw allow 7002/tcp
sudo ufw allow 8090/tcp
sudo ufw allow 9080/tcp

# Apply changes
sudo ufw reload

```

### **3. OS Prerequisites & Time Sync**

The EUM server shares the same library dependencies as the Controller.

* **Libraries:** Ensure `libaio`, `libncurses5`, and `tar` are installed.
* **Timezone:** Must be synchronized with the Controller.

```bash
sudo timedatectl set-timezone America/New_York

```

### **4. Installation Procedure**

1. **Prepare Directory:**
```bash
sudo mkdir -p /opt/appdynamics/EUM
sudo chown -R $USER:$USER /opt/appdynamics/EUM

```


2. **Prepare Installer:**
Move your `.sh` installer to the directory and make it executable:
```bash
sudo chmod +x eum-installer-xxx.sh

```


3. **Execute Setup:**
Run the script. When prompted, select **Production Mode** and carefully record the **Database User and Password** you create.
```bash
./eum-installer-xxx.sh

```



### **5. Post-Installation Configuration**

#### **Update EUM Properties**

Retrieve your `es.eum.key` from `http://controller-host:8090/controller/admin.jsp`. Then, edit `eum.properties` to enable analytics:

```text
analytics.enabled=true
analytics.serverScheme=http
analytics.serverHost=${events-service-hostname}
analytics.port=9080
analytics.accountAccessKey=${your-access-key}

```

#### **Optimize JVM Options** (Optional)

Adjust the memory allocation in the EUM Processor startup script to prevent `OutOfMemory` errors:

```bash
DEFAULT_JVM_OPTS="\
\"-server\" \
\"-XX:+UseConcMarkSweepGC\" \
\"-XX:CMSInitiatingOccupancyFraction=50\" \
\"-XX:+HeapDumpOnOutOfMemoryError\" \
\"-XX:NewRatio=1\" \
\"-Xms4096m\" \"-Xmx4096m\" \
\"-DEUM_COMPONENT=processor\" \
\"-Dlogback.configurationFile=bin/logback.xml\" \
\"-Dcom.mchange.v2.c3p0.cfg.xml=bin/c3p0.xml\""

```

---

## **Troubleshooting (Official Reference)**

### **1. Database Connection Failures**

* **Issue:** The EUM Processor cannot connect to its MySQL database.
* **Detective Check:** Verify the `db.url` in `eum.properties` matches your MySQL host and port. Ensure the MySQL service is running: `systemctl status mysql`.
* **Fix:** If using an external DB, ensure the `bind-address` in MySQL allows remote connections.

### **2. "Stuck" on Extraction (Neustar.dat)**

* **Issue:** Installation hangs at `neustar.dat`.
* **Official Fix:** This file is very large. Ensure you have at least **10GB of free space in /tmp** for the extraction process. If it fails, clean `/tmp` and restart.

### **3. EUM-Controller Communication**

* **Issue:** EUM data is not appearing in the Controller UI.
* **Detective Check:** Check the `eum-processor.log`. Look for `401 Unauthorized`.
* **Fix:** This usually means the `es.eum.key` in `eum.properties` does not match the key in the Controller's `admin.jsp`. Re-copy and restart the EUM Processor.

### **4. Memory Bottlenecks**

* **Issue:** `java.lang.OutOfMemoryError: GC overhead limit exceeded`.
* **Fix:** Increase the `-Xmx` value in your `DEFAULT_JVM_OPTS` to **8192m** (8GB) if your host has enough physical RAM.

### **5. Beacons Not Reaching EUM**

* **Issue:** Browser agents cannot send data to the EUM server.
* **Detective Check:** Open your browser's **Network tab (F12)** and look for failed requests to your EUM host.
* **Fix:** Ensure your **Load Balancer** or Firewall is not blocking port **7001/7002** from the public internet.
