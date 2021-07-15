#!/usr/bin/env bash
# Install: "sudo apt-get install socat"
# Run to connect remotely to RFXtrx433XL, on port 3007

socat file:/dev/serial/by-id/usb-RFXCOM_RFXtrx433XL_DO5OOZ1D-if00-port0,raw,echo=0 tcp4-l:3007
