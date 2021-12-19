I run [Home Assistant](https://www.home-assistant.io/) in Docker on a Raspberry Pi 4.

See the [docker compose](../raspberry/docker/docker-compose.yaml) file for setup.

See the other various files in this folder for descriptions of the integrations I use.

## Integrations

- Tibber
- [Plejd](https://github.com/bnordli/ha-plejd/tree/to-integration)
- Logitech Harmony Hub
- RFXTRX
- Shelly
- Melcloud
- Netatmo
- (Android) Mobile App
- UPS
- Google Cast
- Met.no
- Pi-Hole
- Synology DSM
- Unifi
- Canon printer
- [Time based cover](https://github.com/davidramosweb/home-assistant-custom-components-cover-time-based) 
- HACS
  - Sector Alarm
  - ...

TODO: Add configuration.yaml and other files.

## Automations

Some example of automations I use

- Send mobile notification when garage door is open for too long (and then tap the notification to close it)
- Send mobile notifications when various windows are open for too long
- Time limit a Nexa smart plug connected to the coffee machine, and power on automatically at 7:25 if "armed" the night before (using a Nexa button).
- Control a Nexa smart plug from an Elko wall switch connected to a Shelly
- Control a Shelly relay from a Nexa motion sensor
- Control a Plejd dimmable light from a bed side Nexa button
- Sync Plejd scenarios with HA scenes
- Send mobile notification when power usage first [exceeds 5/10/15.. kWh/hour](https://lede.no/nettleie/) in a month
- Turn on connected TVs when turning on Chromecast (yes, I know I also can use HDMI CEC also)
