# Home Assistant and Logitech Harmony Hubs

Home Assistant has a [Harmony Hub integration](https://www.home-assistant.io/integrations/harmony/) (of course :)).

It supports multiple Hubs in one house, each one added identified by its IP and a name.

The configuration is plug and play: Each hub adds the remote as one device and all its activities as switch entities. Individual IR commands can be sent using
the `remote.send_command` service. (For some reason, the [remote integration](https://www.home-assistant.io/integrations/remote/) only lists one of my remotes,
although both can be used to send commands to.)

## Adding any light and/or switch to the physical remote

If you *don't* have a Philips Hue Bridge (or don't have it connected to the hub), you can add the [Emulated Hue integration] (https://www.home-assistant.io/integrations/emulated_hue/)
to control any HA light and/or switch by the physical remote (or your Harmony Mobile App):

1. Add the integration and configure it as follows:
```
emulated_hue:
  listen_port: 8300
  expose_by_default: false
  entities:
    light.id_1:
      hidden: false
    switch:id_2:
      hidden: false
```

I **strongly** recommend listing all wanted entities by setting `expose_by_default: true`. The first time, I did not, and accidentally turned off the Raspberry Pi itself when sending
"All Lights Off" from the remote..

2. Restart HA and check that the emulator is set up correctly by visiting `http://raspberrypi:8300/api/pi/lights`.
3. Add "Philips Hue" as a "Home Control" device in your Hub.
4. Wait for auto-discovery or enter `[raspberry IP]:8300` as address.
5. You can then group the exposed lights into groups and control them by the touch screen or assign them to the home control buttons.
