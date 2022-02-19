# Hardware

The Raspberry Pi is powered using a [PoE hat](https://www.proshop.no/Mini-PC-Android-Raspberry-Pi/Raspberry-Pi-PoE-HAT/2964666). After the hat is mounted, it is just plug and play. It is installed in [this case](https://www.komplett.no/product/1162231?noredirect=true), and although it claims to support hats, it did not fit the PoE hat exactly, as some screw fasteners needed to be shortened.

## Connected devices

- One [RFXtrx433XL](http://www.rfxcom.com/RFXtrx433XL), used by [Home Assistant](https://github.com/bnordli/home/blob/main/homeassistant/RFXtrx443XL.md).
- One old 160GB Intel SSD mounted in a [2"5 cabinet](https://www.komplett.no/product/760841?noredirect=true), used to offload the SD card.

# Configuration

The Raspberry's SD card was flashed using the [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Since I don't have a screen connected, I chose Raspberry Pi OS Lite (32-bit). Before putting the SD card back in the Raspberry Pi, remember to add an empty file named `ssh` in order to be able to connect to it. The default password is `raspberry` -- be sure to change this during the first login.

To avoid excessive SD card usage, a volume on the [Rackstation](../rackstation) is mounted using [fstab](fstab).

See [config.txt](config.txt) for more configuration.

Areas of interest:
* Since the unit is headless, we can set `gpu_mem=16`
* I found the PoE HAT to be spinning up the fan a little too much. These can be modified by `dtparam=poe_fan_temp*`.

# Docker

To run [Home Assistant](../homeassistant), [Pi-hole](../pihole) and [nginx](nginx), Docker and Docker compose is installed. [Instructions](https://docs.docker.com/compose/install/).

[Configuration](docker).

# Availability checker

Home Assistant (and therefore Raspberry) availability checked using a scheduled [Rackstation](../rackstation) task (`curl -m 3 [raspberry-pi-ip]:8123`, send notification on non-zero exit). Thus I will quickly get an email if the instance cannot be reached.
