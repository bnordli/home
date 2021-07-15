# Docker containers

## Setup

### Install docker

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
```

### Install docker-compose

```
sudo apt-get install -y libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose
sudo systemctl enable docker
```

## Update and restart all containers

```
docker-compose pull
docker-compose up -d --remove-orphans
```
