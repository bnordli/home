I run [Pi-hole](https://pi-hole.net/) and use it for all DNS queries on my local network.

See the [docker compose](../raspberry/docker/docker-compose.yaml) file for setup.

The Raspberry Pi's IP is then set as default DHCP Name Server for all Unifi networks, with fallback to the USG.

TODO: Setup IPv6 DNS,
