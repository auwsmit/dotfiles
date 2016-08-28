#!/bin/bash
mkdir -p /etc/systemd/system/getty@tty1.service.d/
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin aws --noclear %I $TERM
' > /etc/systemd/system/getty@tty1.service.d/override.conf
