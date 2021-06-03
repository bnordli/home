# Connecting with Plejd

* Add the [ha-plejd](https://github.com/klali/ha-plejd) custom plugin. (Note: Extracting the crypto secret was a bit different than documented, see [this issue](https://github.com/klali/ha-plejd/issues/34)
* Mount the Bluetooth socket inside the Docker container using `/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket`
* If the bluetooth service is not running, start it with `sudo invoke-rc.d bluetooth restart`
