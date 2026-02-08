# Air-gapped Real User Monitoring Using a Localized CDN
nginx as CDN server
•	Add the following section to the nginx config file:
```
server {
   listen 8080;
   location /adrum {
root   /opt/jsagent;
   }
}
```
