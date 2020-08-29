#!/bin/bash
#Включить/выключить микрофон

filename=/etc/acpi/acpi-config
user=$(head -n 1 $filename)
var=$(amixer get Capture | grep '\[on\]')

if [[ -z $var ]]; then
  amixer set Capture cap
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Микрофон включен"
else
  amixer set Capture nocap
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Микрофон выключен"
fi