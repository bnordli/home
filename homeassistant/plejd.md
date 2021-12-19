# Connecting with Plejd

* Add the [ha-plejd](https://github.com/bnordli/ha-plejd/tree/to-integration) custom plugin (forked from [klali](https://github.com/klali/ha-plejd), sent as [PR#54](https://github.com/klali/ha-plejd/pull/54)).
* Mount the Bluetooth socket inside the Docker container using `/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket`
* If the bluetooth service is not running, start it with `sudo invoke-rc.d bluetooth restart`

This component can control lights individually, or trigger (and receive) Plejd scenarios. (When setting multiple lights, Plejd scenarios will trigger lights faster than HA scenes.)
