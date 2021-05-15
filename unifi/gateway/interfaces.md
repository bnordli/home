# Port to interface mapping

On both USG and USG Pro 4, all ports can be mapped freely between Network groups (LANs) and WANs. But their network *interface*s are hard wired. Therefore, all special USG configurations must be modified according to your exact port usage.

I am using a USG Pro 4 with one LAN (on the LAN1 port) and one WAN (on the WAN1 port).

The mapping is as follows ([source](https://community.ui.com/questions/USG-and-USG-Pro-ethernet-assignment/2d3d4a2a-23f9-45a6-81bd-4b40e731bfba)), from left to right (as seen from the front):

## Models

### USG Pro 4
* LAN1: eth0
* LAN2: eth1
* WAN1: eth2
* WAN2: eth3
* SFP1: eth2
* SFP2: eth3

**Note:** If an SFP module is inserted into SFPx, the corresponding WANx is disabled.

### USG
* WAN1 (WAN on older models): eth0
* LAN1 (LAN on older models): eth1
* WAN2/LAN2 (VOIP on older models): eth2

## Remapping ports
Port can be remapped under "Devices > [your USG] > Ports > Configure interfaces". In order to move a group to another port, its current port must first be "Disabled".
