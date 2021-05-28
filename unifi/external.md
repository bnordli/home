# Configure Dynamic DNS

Services -> Dynamic DNS -> Create New Dynamic DNS

* Interface: WAN
* Service: {your favorite DynDNS provider, I am using noip}
* Hostname: {your requested hostname}
* Username: {your DynDNS host name}
* Password: {your DynDNS password}
* Server: dynupdate.no-ip.com (for example)

The actual dynamic DNS domain name is irrelevant, as I have a personal domain (bought at [one.com]) which forwards a sub-domain to the DynDNS host using CNAME.

# Configure VPN

## Enable RADIUS Server

Services -> Radius -> Server

* Enable RADIUS Server: ✓
* Secret: A strong password
* Authentication Port: 1812 (default)
* Accounting Pport: 1813 (default)
* Accounting Interim Interval: 3600 (default)
* Tunnelled Reply: ✓

## Add RADIUS users

Services -> Radius -> Users -> Create new user

* Name: username
* Password: A strong password
* VLAN: blank (to use the default)
* Tunnel Type: 3 - L2TP
* Tunnel Medium Type: 1 - IPv4

(Repeat for each user)

## Create VPN network

Networks -> Create New Network

* Name: Anything
* Purpose: Remote User VPN
* VPN Type: L2TP Server
* Pre-Shared Key: A strong password
* Gateway IP/Subnet: 10.117.5.10/24 (Something not assigned to any other network)
* Name Server: Auto
* RADIUS Profile: Default (Using the RADIUS server created above)
* MS-CHAPv2: ✓

# Connect using VPN

## Android

Settings -> More connections -> VPN

* Name: Home
* Type: L2TP/IPSec PSK
* Address: {the personal or dynamic DNS host name}
* IPSec pre-shared key: The VPN network password
* Username/password: The user specific credentials

### Notes

It doesn't seem to be possible to get proper mDNS through VPN, since that would need layer 2 connectivity, which is not supported on Android
