#!/bin/bash
#Увеличение звука

filename=/etc/acpi/acpi-config
user=$(head -n 1 $filename)

sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Стало громче на 3%"
amixer -q sset Master 3%+