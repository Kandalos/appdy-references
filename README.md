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



2-Event Services:
-
1. Create Linux ( 16-32GB RAM, 1TB, 4 Cores)
2. Install Ubuntu
3. Open Ports 9080 :
   
   ```
   sudo ufw allow 9080/tcp
   sudo ufw reload
   
   ```
   
