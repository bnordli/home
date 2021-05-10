# Rackstation

## Fan control
Having a slim form factor, the Rackstation has three small fans, and Synology has configured them
to run very aggressively. That resulted in an unbearable high pitched noise reaching into the
neighboring rooms (possibly transmitted via the wall mounted rack) into the wall structure. I did
consider returning the unit before finding this very helpful page at [return2.net](https://return2.net/how-to-make-synology-diskstation-fans-quieter/).

I use the NAS sporadically, but still want it to run continuously, so it is not an option to
schedule on/off times (potentially with Wake On Lan). I therefore decided to override the fan
configuration and follow the instructions at the page above. It is repeated here:

(Notice: All configuration changes are made at your own risk.)

1. Verify that the Fan Speed Mode (Control Panel > Hardware & Power > General) is *not* set to "Full-speed mode" (obviously). As you can read below, after reconfiguration it doesn't really matter whether you select "Cool mode" or "Quiet mode".

2. Enable HDD Hibernation (Control Panel > Hardware & Power > HDD Hibernation) and set a hibernation
time that suits your usage pattern (I set mine to 20 minutes).

3. Enable the SSH service (Control Panel > Terminal & SNMP > Terminal)

4. "shush" into the unit from any connected machine: `ssh [username]@[local IP]`

    a. Move to root to be able to modify configuration: `sudo -i`
  
    b. Create a startup script to disable the fan check to avoid alerts flooding.\
       (The parameters folder is different from model to model, and the first line locates it on your specific instance. On my RS819 it is at `/sys/module/apollolake_synobios/parameters`.)
     
    ```
    cf=`find /sys/module/*/parameters/check_fan`
    echo '#!/bin/sh' > /usr/local/etc/rc.d/fan_check_disable.sh
    echo "echo 0 > $cf" >> /usr/local/etc/rc.d/fan_check_disable.sh
    chmod 755 /usr/local/etc/rc.d/fan_check_disable.sh
    ```
   
    After this, the `/usr/local/etc/rc.d/fan_check_disable.sh` file should look something like

    ```
    #!/bin/sh
    echo 0 > /sys/module/rs819_synobios/parameters/check_fan
    ```

    c. Modify the fan profile during hibernation:
      - Make a backup: `cp /usr/syno/etc.defaults/scemd.xml /usr/syno/etc.defaults/scemd.xml.bak`
      - Put [this file](scemd.xaml) (or just the top `fan_config` tag of it) in `/usr/syno/etc.defaults/scemd.xml`.
      - Set the new settings during startup: `cp /usr/syno/etc.defaults/scemd.xml /usr/syno/etc/scemd.xml`

5. Restart the unit to apply the new configuration (or just `synoservice --restart scemd`, but I didn't try this).

You can modify the `scemd.xml` to your liking. It sets the fan speed percentage from the temperature readings of the CPU and all disks. (Readings are in Celsius.)

`DUAL_MODE_HIGH` corresponds to "Cool mode" and `DUAL_MODE_LOW` to "Quet mode". The rest of the `fan_config` tags relate to Synology expansion units and have not been relevant to me.
