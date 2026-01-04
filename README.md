# Installing and configuring AppDynamics using Ubuntu Server

Appdynamics splunk has 3 main components: 
1. Controller & Enterprise Console
2. Events Services
3. EUM ( End User Monitoring )

Each Component has to be installed seperatly.

Controller & Enterprise Console:
-
1. Create Linux Server ( 16GB RAM, <50GB, 4 Cores )
2. Install Ubunutu
3. Open Ports 9191, 8090
   ```
   ufw allow

   ```



Event Services:
-
1. Create Linux ( 16-32GB RAM, 1TB, 4 Cores)
2. Install Ubuntu
3. Open Ports 9080 :
   ```
   ufw allow
   ```
   
