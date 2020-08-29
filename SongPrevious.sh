#!/bin/bash
#Пердыдущая музыка

filename=/etc/acpi/acpi-config
user=$(head -n 1 $filename)
AudioCheck=$(sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus playerctl status | grep 'Playing')

if [[ -z $AudioCheck ]]; then
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Невозможно переключить"
else
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Предыдущая песня" &&
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus playerctl previous
fi