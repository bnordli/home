# Installation

```
sudo apt-get install certbot
sudo mkdir /etc/letsencrypt
sudo mkdir /var/lib/letsencrypt
sudo chown pi:pi /etc/letsencrypt
sudo chown pi:pi /var/lib/letsencrypt
mkdir -f /home/pi/certbot/www
```

* Start nginx with the bootstrap configuration
* Request certificate: `certbot certonly --webroot -w /home/pi/certbot/www --email bnordli@gmail.com -d home.plingri.net -d ph.home.plingri.net -d rs.home.plingri.net -d ha.home.plingri.net -d ck.home.plingri.net --rsa-key-size=4096 --agree-tos --force-renewal --logs-dir /home/pi/certbot/log`
* Restart nginx with the normal configuration

# Renewal

`certbot renew --logs-dir /home/pi/certbot/log`

which is best done using `crontab`
