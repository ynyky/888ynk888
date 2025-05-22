# HOW to install nextcloud
## Pre-requirements
- ubuntu-24.04.2-live-server-amd64.iso https://releases.ubuntu.com/noble/

## run inside vm console:
add sudo on beggining if needed 
```
apt update -y 
apt upgrade -y
apt install -y git
git clone <TOKEN>
cd 888ynk888/nextcloud
chmod u+x requirements.sh
./requirements.sh
exit
docker compose -f docker-compose.yaml up -d 
```
## Post requirements 
add your vm ip to dns
```
<your_vm_ip> nextcloud.example.com
```
## HOW TO CHECK/CHANGE SETUP
### CHECK
```
cat .env
```
### CHANGE
``` 
docker compose -f docker-compose.yaml down # turn off docker compose
vim .env
```
```
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=nextcloud
MYSQL_PASSWORD=nextcloud
MYSQL_DATABASE=nextcloud
MYSQL_HOST=db
REDIS_HOST=redis
OVERWRITEPROTOCOL=https
TRUSTED_PROXIES=caddy
APACHE_DISABLE_REWRITE_IP=1
OVERWRITEHOST=nextcloud.example.com
```
* rerun docker-compose
```
docker compose -f docker-compose.yaml up -d 
```


### HOW TO SETUP 
1. Don't install init application on start
2. Install onlyoffice 
3. run sctip ./init_script.sh
3. Setup onlyoffice 

host: https://onlyoffice.example.com/
turn on: don't verify cert
add secret: "mysecret"
modify header: from Authorization to AuthorizationJwt
