#!/bin/bash
#Выключить/включить звук

filename=/etc/acpi/acpi-config
user=$(head -n 1 $filename)
var=$(amixer get Master | grep '\[on\]')

if [[ -z $var ]]; then
  amixer -D pulse sset Master unmute
  amixer -c 0 set Master unmute
  amixer cset numid=4 on
  sudo -u $user amixer cset numid=4 on
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Звук включен"
else
  amixer -D pulse sset Master mute
  amixer -c 0 set Master mute
  amixer cset numid=4 off
  sudo -u $user amixer cset numid=4 off
  sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Звук выключен"
fi