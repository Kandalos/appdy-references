# Installing and configuring AppDynamics using Ubuntu Server

Appdynamics splunk has 3 main components: 
1. Controller & Enterprise Console
2. Events Services
3. EUM ( End User Monitoring )

Each Component has to be installed seperatly.

1-Controller & Enterprise Console:
-
1. Create Linux Server ( 16GB RAM, <50GB, 4 Cores )
2. Install Ubunutu
3. Open Ports 9191, 8090
   
   ```
   sudo ufw allow 9191/tcp
   sudo ufw allow 8090/tcp
   sudo ufw reload
   ```
4. Set timedatectl
   ```
   sudo timedatectl set-timezone America/New_York
   ```
5. install/update software requirements:
   1. Libaio:
   
      Check if it exist: 
      ```
      ls /lib/x86_64-linux-gnu/ -a | grep libaio
      ```
      There must be libaio.so.1 ( symlink if doesnt exist)
      ```
      sudo ln -s /lib/x86_64-linux-gnu/libaio.so.1t64 /lib/x86_64-linux-gnu/libaio.so.1
      ```
   2. libncurses:

       Check if it exist: 
      ```
      ls /lib/x86_64-linux-gnu/ -a | grep libncurses*
      ```
      There must be libncurses.so.5 ( symlink if doesnt exist)
      ```
      sudo ln -s /lib/x86_64-linux-gnu/libncurses.so.6.4 /lib/x86_64-linux-gnu/libncurses.so.5
      sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6.4  /lib/x86_64-linux-gnu/libtinfo.so.5
      ```
   3. netstat: ``` sudo apt-get install net-tools```

      
6. Copy controller installer into ```/opt/appdynamics``` and execute the installer:
   
   Create the directory /opt/appdynamics
   ```
   sudo mkdir /opt/appdynamics/platform
   ```
   Give it permissions:
   ```
   sudo chown user:user /opt/appdynamics/platform
   ```
   Finally Copy files using scp and run platform-setup-xxx.sh using silent installation method
   Create response.varfile:
   ```
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
   make the setup file executeable and use silent installer method:
   ```
   chmod +x platform-setup-64bit-xxx.sh
   platform-setup-64bit-xxx.sh -q -varfile c:/response.varfile
   ```

   

---

2-Event Services:
-
1. Create Linux ( 16-32GB RAM, 1TB, 4 Cores)
2. Install Ubuntu
3. Open Ports 9080 :
   
   ```
   sudo ufw allow 9080/tcp
   sudo ufw reload
   ```
4. Set timedatectl
   ```
   sudo timedatectl set-timezone America/New_York
   ```

