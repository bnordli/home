# Monitoring UPS status via Rackstation

I use the [Network UPS Tools (NUT) integration](https://www.home-assistant.io/integrations/nut/) to monitor the status of my UPS. It has a *lot* of sensors, you
probably only need the "Battery Charge", "Battery Runtime" and "Ups Load" and "Ups Status".

The UPS server is enabled in Rackstation/Diskation in Control Panel > Hardware & Power > UPS > Enable UPS support > Enable network UPS server.
(You can then enter the IP adress of HA to restrict connection to only that IP.)
