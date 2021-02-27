# LinuxFixFN [ENG]
Cure FN keys on laptop/PC with Arch Linux

FN + .. that I have:
1. F1 - mute sound (+)
2. F2 - less volume (+)
3. F3 - more volume (+)
4. F4 - turn off microphone (+)
5. F5 - refresh the page (-)
6.F6 - turn off the touchpad (-)
7.F7 - flight mode (-)
8. F8 - turn off the camera (-)
9.F9 - lock (put the lock on the laptop) (-)
10.F10 - switching the main display (-)
11.F11 - less brightness (-)
12.F12 - more brightness (-)
13. Start/pause music - Start/pause music (+)
14. Switch to track to the left - Switch to track to the left (+)
15. Switch to track to the right - Switch to track to the right (+)

- NOT decided
+ decided

Items 11 and 12 begin to work after exiting standby mode (suspend) :/

Decision:
1.pamac install acpid acpi-support acpi acpitool
2.systemctl start acpid.service
3.systemctl enable acpid.service
4.pamac install playerctl (if there are keys that manipulate music)
5.acpi_listen

Now you need to press Fn + F (1..12) after which you will see something like this:

button/mute MUTE 00000080 00000000 K
button/volumedown VOLDN 00000080 00000000 K
button/volumeup VOLUP 00000080 00000000 K
button/f20 F20 00000080 00000000 K
cd/play CDPLAY 00000080 00000000 K
cd/prev CDPREV 00000080 00000000 K
cd/next CDNEXT 00000080 00000000 K

There are not all 12 lines here, since I have not decided everything yet.

6. Go to the/etc/acpi/folder
7. Run git clone in the folder https://github.com/xihnik/LinuxFixFN.git
8. Open the config/etc/acpi/acpi-config
9. Change your_user in it to your username.
10. Restart the laptop/PC and everything should work, or you can restart the controller responsible for the FN keys with this command: systemctl disable acpid.service && systemctl enable acpid.service

If you want to add your own handlers, then a quick tour:
Go to the/etc/acpi/folder in this folder are bash scripts that are executed when you press FN + F1 (1..12). Go to the/etc/acpi/events/folder in this folder there are configs that are responsible for calling scripts.

For example, we want to add processing for pressing FN + F1 (I have this to turn on/off the sound):
1. Go to the/etc/acpi/events/folder
2. Add a file without extension for example VolumeToggle
3. Open it
4. Add the FN + F1 value:
Here is the FN + F1 obtained with acpi_listen: button/mute MUTE 00000080 00000000 K
We need to turn this text from this event = button/other (FUNC | HOTK) 00000070 into this event = button/mute (MUTE | HOTK) 00000080

What we did:
button/other was replaced with button/mute
FUNC has been replaced by MUTE
00000070 was replaced by 00000080

5. Hanging the bash script on the action
action =/etc/acpi/VolumeToggle.sh% e
6. Go to the/etc/acpi/folder
7. Create file VolumeToggle.sh and make it executable (file properties-> rights)
8. Open it with an editor
9. And add the following:

``` bash
#!/bin/bash
# Turn off/turn on sound

filename =/etc/acpi/acpi-config
user = $ (head -n 1 $ filename)
var = $ (amixer get Master | grep '\ [on \]')

if [[-z $ var]]; then
  amixer -D pulse sset Master unmute
  amixer -c 0 set Master unmute
  amixer cset numid = 4 on
  sudo -u $ user amixer cset numid = 4 on
  sudo -u $ user DISPLAY =: 0 DBUS_SESSION_BUS_ADDRESS = unix: path =/run/user/1000/bus notify-send "Sound on"
else
  amixer -D pulse sset Master mute
  amixer -c 0 set Master mute
  amixer cset numid = 4 off
  sudo -u $ user amixer cset numid = 4 off
  sudo -u $ user DISPLAY =: 0 DBUS_SESSION_BUS_ADDRESS = unix: path =/run/user/1000/bus notify-send "Sound off"
fi
```

* Here we have described what happens when you call FN + F1

10. Restart the laptop/PC and everything should work, although you can also restart the controller responsible for FN handlers with this command: systemctl disable acpid.service && systemctl enable acpid.service 

# LinuxFixFN [RU]
Вылечить FN клавиши на ноутбуке/ПК с Arch Linux

FN + .. , которые у меня есть:
1. F1 - выключить звук (+)
2. F2 - меньше громкость (+)
3. F3 - больше громкость (+)
4. F4 - выключить микрофон (+)
5. F5 - обновить страницу (-)
6. F6 - выключить тачпад (-)
7. F7 - режим в полете (-)
8. F8 - выключить камеру (-)
9. F9 - замок (поставить замок на ноутбук) (-)
10. F10 - переключение основного дисплея (-)
11. F11 - меньше яркость (-)
12. F12 - больше яркость (-)
13. Пуск/пауза музыки - Пуск/пауза музыки (+)
14. Переключить на трек влево - Переключить на трек влево (+) 
15. Переключить на трек вправо - Переключить на трек вправо (+)

- НЕ решено
+ решено

Пункты 11 и 12 начинают работать после выхода из ждущего режима (suspend) :/

Решение:
1. pamac install acpid acpi-support acpi acpitool
2. systemctl start acpid.service
3. systemctl enable acpid.service
4. pamac install playerctl (если есть клавиши, которые манипулируют с музыкой)
5. acpi_listen

Теперь нужно нажать на Fn + F(1..12) после чего у вас отобразится примерно такой текст:

button/mute MUTE 00000080 00000000 K
button/volumedown VOLDN 00000080 00000000 K
button/volumeup VOLUP 00000080 00000000 K
button/f20 F20 00000080 00000000 K
cd/play CDPLAY 00000080 00000000 K
cd/prev CDPREV 00000080 00000000 K
cd/next CDNEXT 00000080 00000000 K

Здесь не все 12 строчек, так как еще не все решил.

6. Зайдите в папку  /etc/acpi/
7. Выполните в папке git clone https://github.com/xihnik/LinuxFixFN.git
8. Откройте конфиг /etc/acpi/acpi-config
9. Измените в нем your_user на название вашего пользователя.
10. Перезапустите ноутбук/ПК и все должно заработать или можно этой командой перезапустить контроллер отвечающий за FN клавиши: systemctl disable acpid.service && systemctl enable acpid.service

Если вы хотите добавить свои обработчики, тогда краткий экскурс:
Зайдите в папку  /etc/acpi/ в этой папке лежат bash скрипты, которые выполняются при нажатии на FN+F1(1..12). Зайдите в папку /etc/acpi/events/ в этой папке лежат конфиги, которые и отвечают за вызов скриптов.

К примеру мы хотим добавить обработку нажатия на FN+F1 (у меня это включить/выключить звук):
1. Зайдите в папку /etc/acpi/events/
2. Добавьте файл без расширения к примеру VolumeToggle
3. Откройте его
4. Добавьте значение FN+F1:
Вот FN+F1 полученный с помощью acpi_listen: button/mute MUTE 00000080 00000000 K
Нам нужно превартить этот текст из этого event=button/other (FUNC|HOTK) 00000070 в этот event=button/mute (MUTE|HOTK) 00000080

Что мы сделали:
button/other заменили на button/mute
FUNC заменили на MUTE
00000070 заменили на 00000080

5. Навешиваем bash скрипт на action
action=/etc/acpi/VolumeToggle.sh %e
6. Зайдите в папку /etc/acpi/
7. Создайте файл VolumeToggle.sh и сделайте его исполняемых (свойства файла->права)
8. Откройте его редактором
9. И добавьте следующее:

```bash
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
```

*Здесь мы описали, что произойдет при вызове FN+F1

10. Перезапустите ноутбук/ПК и все должно заработать хотя можно и этой командой перезапустить контроллер отвечающий за FN обработчики: systemctl disable acpid.service && systemctl enable acpid.service
