# IPTV from Telenor (T-We) with Unifi gear

Telenor doesn't officially support IPTV over custom routers (or even switches). But as of June 2020, some third party documentation from Telenor can be found [here](https://www.telenor.no/binaries/privat/kundeservice/tvhjelp/utstyr/tredjeparts-utstyr/IPTV%20tredjepart%20veiledning%20juni%202020.pdf) (in Norwegian).

After scouring multiple forums and blog posts I have found a setup that works fairly stable for me, even after replacing the Telenor supplied router with a Security Gateway. 

I have two [T-We Box II](https://www.telenor.no/privat/tv/t-we/dekoder/) decoders running IPTV over Ethernet. They are both directly cabled to my Unifi Switch 24. (I don't have any reason to suspect the setup is different with the older [T-We Box I (ADB 5743)](https://www.telenor.no/privat/kundeservice/tvhjelp/utstyr/abd5743/) decoders.)

**Note:** The UniFi Dream Machines (UDM and UDM Pro) cannot run an IGMP proxy, so they generally *cannot* be used as gateways/routers supporting multicast IPTV.

## Description of the technical solution

To avoid network congestion, Telenor delivers live channels over [IP/UDP multicast](https://en.wikipedia.org/wiki/Multicast). Destinations register themselves to multicast groups using [IGMPv3](https://en.wikipedia.org/wiki/Internet_Group_Management_Protocol). Your home network must therefore support IGMP and route the multicast messages correct internally.

Non-live television ("Ukesarkiv", "Start forfra", "Filmleie" and other services) is sent over normal TCP/IP, but Telenor claims some UPnP(-IGD) functionality is needed for this, although I haven't seen any evidence that the decoder has registered any routing changes (see "Insights -> Port Forward Stats -> UPnP").

Fortunately, Telenor doesn't send IPTV traffic to your router in a separate VLAN, so your USG doesn't need to "untag" any VLAN traffic on the WAN side. You can of course put your decoders in a separate VLAN internally, and it might actually be beneficial in order to have total isolation of the multicast messages.

## Switch (layer 2) setup

### Enable IGMP snooping

In order for the switches to send the multicast messages to the correct endpoints (and not everywhere else), these settings must be enabled:
* In "Settings -> Networks", edit the LAN network (or the VLAN your decoder is assigned to)
  - Enable IGMP snooping

*If* you have your decoders on WIFI (which is not really recommended), you would want filter multicast on the WLAN. I think this setting is useful either way:
* In "Settings -> Wireless Networks", edit the network the decoder is connected to and check
  - Enable multicast enhancement (IGMPv3)

**Note:** The UniFi Switch Flex Mini (4 port switch) does *not* support IGMP snooping, so it is not recommended to connect a decoder through any of these.
(If you do, it will send out received multicast packages to all its connected clients.)

### Enable UPnP
As noted above, I haven't seen any evidence this is needed, but I have it enabled like this:
* In "Settings -> Services -> UPnP"
  - Configuration
    * Enable UPnP
    * Enable NAT Port Mapping Protocol
    * Enable Secure Mode (since the setup works with this on, it should work without as well)
  - Networks
    * Enable LAN (or the VLAN your decoder is assigned to)

## Gateway (layer 3) setup
If you have decided to replace the Telenor supplied router with a Security Gateway, there are several more steps needed in order to correctly route the TV traffic.

### Modify the firewall
TODO: Details to be added
* Multicast (UDP) messages originating from Telenor must be able to pass through the Gateway (WAN_IN)
* IGMP messages from Telenor must be received by the Gateway (WAN_LOCAL)
Telenor's IP have been identified [here](https://stavdal.me/2019/05/how-to-set-up-iptv-multicast-from-telenor-fibre-on-usg-3p/) as 224.0.0.0/4, 93.91.111.0/24 and 148.222.7.125.

You also need to disable strict source validation, see below.

### Enable IGMP proxy (and disable strict firewall)
The Gateway must act as an IGMP proxy to translate the IGMP messages to and from the internal network. This cannot be configured in the UI, so you need to put a [`config.gateway.json`](gateway/config.gateway.json) file on the UniFi *Controller* and then reprovision the gateway.

`ssh` to the controller and `cd` to the [unifi-base](https://help.ui.com/hc/en-us/articles/115004872967-UniFi-Where-is-unifi-base-) folder:
```
cd /usr/lib/unifi
```
Then identify your site id (the next folder after `/manage/site/` in the management UI, most probably `default`) and continue with the following commands:
```
site=<site id or "default">
mkdir -p data/sites/${site}
cd data/sites/${site}
cat > config.gateway.json
```
For USG Pro 4, paste the contents of [`config.gateway.json`](gateway/config.gateway.json) and end with `ctrl-D`.
For Regular USG, copy the file locally and change "eth0" to "eth1" and "eth2" to "eth1".

Reprovision the Gateway using the UI and then verify that igmp-proxy is running by `ssh`-ing to the *Gateway*  and running `ps aux | grep igmp` to verify that `/sbin/igmpproxy` is running.

