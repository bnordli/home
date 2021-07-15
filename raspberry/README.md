# Raspberry configuration

Running headless, so gpu_mem=16.

Fan speeds modified by dtparam=poe_fan_temp*

Rackstation volume persistently mounted using fstab.

Home Assistant (and therefore Raspberry) availability checked using a scheduled [Rackstation](../rackstation) task (`curl raspberrypi:8123`, send notification on non-zero exit).
