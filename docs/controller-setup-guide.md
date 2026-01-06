## 1. Controller & Enterprise Console Installation

### System Requirements

| Resource | Requirement |
| --- | --- |
| **CPU** | 4 Cores |
| **RAM** | 16 GB |
| **Storage** | 50 GB+ |
| **OS** | Ubuntu Server |

### Step 1: Network & OS Configuration

1. **Open Required Ports:**
```bash
sudo ufw allow 9191/tcp
sudo ufw allow 8090/tcp
sudo ufw reload

```


2. **Set Timezone:**
The Controller requires synchronized time for accurate monitoring data.
```bash
sudo timedatectl set-timezone America/New_York

```



### Step 2: Install Software Requirements

Modern Ubuntu versions often have newer libraries than the installer expects. We must ensure the specific versions are available via symlinks.

1. **Libaio:**
Check if it exists:
```bash
ls /lib/x86_64-linux-gnu/ -a | grep libaio

```


If `libaio.so.1` is missing, create the symlink:
```bash
sudo ln -s /lib/x86_64-linux-gnu/libaio.so.1t64 /lib/x86_64-linux-gnu/libaio.so.1

```


2. **libncurses:**
Check if it exists:
```bash
ls /lib/x86_64-linux-gnu/ -a | grep libncurses*

```


The installer looks for version 5. Create symlinks from version 6 if necessary:
```bash
sudo ln -s /lib/x86_64-linux-gnu/libncurses.so.6.4 /lib/x86_64-linux-gnu/libncurses.so.5
sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6.4  /lib/x86_64-linux-gnu/libtinfo.so.5

```


3. **Net-tools:**
```bash
sudo apt-get install net-tools -y

```



### Step 3: Preparation & Directory Setup

Create the installation directory and set the appropriate ownership (replace `user` with your actual Linux username).

```bash
sudo mkdir -p /opt/appdynamics/platform
sudo chown -R user:user /opt/appdynamics

```

### Step 4: Silent Installation

Copy the installer to the server using `scp`. Then, create a `response.varfile` to automate the installation.

**Create the file:** `nano /opt/appdynamics/response.varfile`
**Paste the following content:**

```ini
serverHostName=HOST_NAME
sys.languageId=en
disableEULA=true

platformAdmin.port=9191
platformAdmin.databasePort=3377
platformAdmin.dataDir=/opt/appdynamics/platform/mysql/data
platformAdmin.databasePassword=ENTER_PASSWORD
platformAdmin.databaseRootPassword=ENTER_PASSWORD
platformAdmin.adminPassword=ENTER_PASSWORD
platformAdmin.useHttps$Boolean=false
sys.installationDir=/opt/appdynamics/platform

```

**Run the installer:**
Make the file executable and run it using the `-q` (quiet) flag pointing to your varfile.

```bash
chmod +x platform-setup-64bit-xxx.sh
./platform-setup-64bit-xxx.sh -q -varfile /opt/appdynamics/response.varfile

```

### Step 5: Verification & Express Install

Once the installation finishes, navigate to ```server-ip-address:9191``` and install Controller using the GUI.

---
