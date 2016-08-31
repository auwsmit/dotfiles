#!/bin/bash
# This script will cause virtual terminal 1 to
# automatically login for systems running systemd.
mkdir -p /etc/systemd/system/getty@tty1.service.d/
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin aws --noclear %I $TERM
' > /etc/systemd/system/getty@tty1.service.d/override.conf
