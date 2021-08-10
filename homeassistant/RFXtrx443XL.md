# Making Home Assistant speak 433MHz

RFXCOM makes the extremely handy (but not very beautiful) [RFXtrx433XL](http://www.rfxcom.com/RFXtrx433XL) USB controller, which integrates into
Home Assistant using the [rfxtrx integration](https://www.home-assistant.io/integrations/rfxtrx/).

The good part (especially for me) is that it comes with a 433.42 MHz transmitter, which is used by [Somfy](https://www.somfy.no/produkter/smart-home-og-kontroller/kontroller-og-sensorer/alle-kontroller) remotes.

Its companion programs are extremely crude, but other than that the device does exactly what it promises. (The User Guide can be downloaded from [here](http://www.rfxcom.com/downloads.htm).)

## Buying
It seems like [some](https://www.kjell.com/no/produkter/smarte-hjem/kontroller/rfxtrx433xl-usb-kontroller-p88434) [Norwegian](https://www.tronika.no/en/smarthome/x10-rfxcom-products/x-10-interfaces/transceiver-rfxtrx433xl.html)
outlets have carried the item before, but I had to buy it from [ebay](https://www.ebay.com/itm/124732176746).

## Setup
*Note: A Windows computer is needed*
1. Download RFXmngr, RFXflash Programmer and the most recent firmware bundle from [here](http://www.rfxcom.com/downloads.htm).
2. Plug the controller into a free USB port of a Windows machine.
3. Run the RFXflash program (don't be afraid of the UI) and press the menu buttons in order:
    1. Connect to the device.
    2. Open the latest firmware from the firmware bundle (RFXtrx433XL_ProXL1_????.hex).
    3. Write to the device.
    4. Wait until the operation is complete and close the program.
4. Optionally install and then run the RFXmngr program (yes, you can be a little afraid now).
    1. Connect to the device.
    2. Set the receiver frequency and press your existing transmitters to see if they are picked up.
   
### Connect to blinds controlled by the Somfy RTS protocol
1. In RFXmngr, go to the "RFY" tab.
2. For each blind you want to control:
     1. Power off all *other* Somfy controlled devices.
     2. Use your existing Somfy remote (set to the correct channel) and press the "Program" button (usually a small reset-type recess on the back).
     3. In the "RFY" tab, select any ID and Unit Code combination (you haven't used before).
     4. Select Command "Program" and then "Transmit" it.
     5. The blinds should move up and down slightly to acknowledge the new "remote".
     6. Test the connection by sending some "Up", "Down" and then "Stop/My" commands.
3. (Power on all devices afterwards.)
 
### Connect to Nexa switches
Example of some [AC units](https://www.clasohlson.com/no/Nexa-MYC-3-fjernstr%C3%B8mbryter-3-pk/p/Pr366902000).
Example of an [ARC unit](https://www.clasohlson.com/no/Nexa-MWST-1812-tr&aring;dl&oslash;s-bryter/p/36-9049).
1. In RFXmngr, go to the "Main" tab.
2. Enable the "AC" and "ARC" protocols.
3. Press any Nexa remote/switch you and verify that they show up in the big ugly yellow box.
4. Take notes of the respective subtype/ID/housecode/unitcode values.
5. If you want to test transmission, go to the "Lighting1" tab and select the "ARC" type, or the "Lighting2" tab and select the "AC" type,
input the values noted above, send your command and observe the results.

### Connect to Cotech weather stations
[Example](https://www.clasohlson.com/no/V&aelig;rstasjon-med-fargeskjerm/p/36-6832).
1. In RFXmngr, go to the "Main" tab.
2. Enable the "Rubicson,Alecto,Banggood" protocol.
3. When a supported weather station report values, they should appear in the yellow box.

## Setup in Home Assistant
After the initial setup, the device can be moved to Raspberry Pi (or whichever computer runs Home Assistant).
(After moving, the RFXmngr can connect remotely using `socat`, example script [here](../raspberry/rfx_remote.sh).)

1. Find the USB device id using `ls /dev/serial/by-id`
2. Mount the USB device inside the HA container:
```
devices:
  - /dev/serial/by-id/usb-RFXCOM_RFXtrx433XL_[ID]-if00-port0:/dev/ttyRFXtrx
```
3. Add the [`rfxtrx` HA integration](https://www.home-assistant.io/integrations/rfxtrx/) using the address `/dev/ttyRFXtrx`.
4. Select "Enable automatic add" to autodiscover devices. **Note: This might add your neighbor's weather stations, lights and/or smoke detectors. If this occurs, please disable those entities as soon as they are discovered.**
5. I had to add my Somfy RTS remotes manually, using the event codes `071a000[ID]0[Unit Code]`. Example for ID `1 02 03` and Unit Code `2`: `071a000001020302`.
