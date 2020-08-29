#!/bin/bash
#Включить музыку

filename=/etc/acpi/acpi-config
user=$(head -n 1 $filename)
MusicPlay=$(sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus playerctl status | grep 'Playing')
MusicStop=$(sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus playerctl status | grep 'Paused')

if [[ -z $MusicPlay ]]; then
  if [[ -z $MusicStop ]]; then
    sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Аудиоплеер не обнаружен"
  else
    sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Музыка включена"
  fi
elif [[ -z $MusicStop ]]; then
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Музыка отключена"
else
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Нет доступных аудиоплееров"
fi

sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus playerctl play-pause