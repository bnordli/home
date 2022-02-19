# Garage

My garage door is a Hörmann Supramatic E3. Unfortunately, it is running a proprietary protocol for wireless signals, but it does have connectors that will operate the
door when connected, and a 24V output. A perfect job for a [Shelly 1](https://shelly.cloud/products/shelly-1-smart-home-automation-relay/)!

## Hooking up the Shelly 1

It is just a matter of identifying the 24V pins and the control pins, and making the correct connections.
I mostly used [this tutorial](https://savjee.be/2020/06/make-garage-door-opener-smart-shelly-esphome-home-assistant/). Note that the garage door only needs a
short pulse to perform an action, so the Shelly is set to "Auto Off" after 1 second.

Since the system is low voltage (all running behind the door's transformer), you don't need an electrician to do the wiring.

It is important to known when the door is open, as it is usually operated using the Hörmann transponder, which Home Assistant knows nothing about. I initially tried a Nexa door sensor to verify that the garage door is closed, but coverage was a bit unstable, so I hooked up a [dumb magnet sensor](https://www.kjell.com/no/produkter/hjem-fritid/alarm-og-sikkerhet/alarmsystemer/detektorer-sensorer-og-annet-tilbehor/magnetkontakt-nc-p50500)
to the Shelly input. It was a little hard to find a working placement for the sensor, but I did finally find one. (I used some leftover speaker cables for the wiring, since it had
exactly the correct length, so the gauge is a little overkill for 24V.)

## Connecting to Home Assistant

Many tutorials recommend the mqtt protocol to hook up Shellys to Home Assistant, but I have found the [Shelly integration](https://www.home-assistant.io/integrations/shelly/)
(using CoIoT) to work perfectly. Just update the firmware, go to "Internet & Security -> Advanced, Developer Settings -> Enable CoIoT" and set the HA CoIoT address (IP:5683) as the peer.

I am using the [Cover Time Based Component](https://github.com/davidramosweb/home-assistant-custom-components-cover-time-based) to define the garage door as a cover. Its position
is based on the Shelly input state, and any action (open/close/stop) is transformed to turn on the Shelly channel (which will auto power off after 1 second).

## Automations

- When the Shelly input changes state to "on" (magnet sensor loses contact) -> Set known action for the time based cover to "opening"
- When the garage door is left open for 20 minutes -> Send an app notification with a "close_garage" action
- When the "close_garage" action is executed -> Close the cover
- When the Shelly input changes state to "off" (magnet sensor reports contact) -> Set the known position to 0 and clear the App notification
