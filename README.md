# LinuxFixFN
Вылечить FN клавиши на ноутбуке/ПК с Arch Linux

FN клавишы, которые у меня есть:
+ 1. F1 - выключить звук
+ 2. F2 - меньше громкость
+ 3. F3 - больше громкость
+ 4. F4 - выключить микрофон
- 5. F5 - обновить страницу
- 6. F6 - выключить тачпад
- 7. F7 - режим в полете
- 8. F8 - выключить камеру
- 9. F9 - замок (поставить замок на ноутбук)
- 10. F10 - переключение основного дисплея
- 11. F11 - меньше яркость
- 12. F12 - больше яркость
+ 13. Пуск/пауза музыки - Пуск/пауза музыки
+ 14. Переключить на трек влево - Переключить на трек влево 
+ 15. Переключить на трек вправо - Переключить на трек вправо 

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
7. Выполните в папке git clone 
8. Откройте конфиг /etc/acpi/acpi-config
9. Измените в нем your_user на название вашего пользователя.
10. Перезапустите ноутбук/ПК и все должно заработать или можно этой командой перезапустить контроллер отвечающий за FN клавиши systemctl disable acpid.service && systemctl enable acpid.service



Если вам нужно именно Не работают функциональные клавиши на ноутбуке (у меня в таком порядке):
+ 1. F1 - выключить звук
+ 2. F2 - меньше громкость
+ 3. F3 - больше громкость
+ 4. F4 - выключить микрофон
- 5. F5 - обновить страницу
- 6. F6 - выключить тачпад
+ 7. F7 - режим в полете (оно раньше работало исправлять не стал)
- 8. F8 - выключить камеру
- 9. F9 - замок (поставить замок на ноутбук)
- 10. F10 - переключение основного дисплея
- 11. F11 - меньше яркость
- 12. F12 - больше яркость
+ 13. Пуск/пауза музыки - Пуск/пауза музыки
+ 14. Переключить на трек влево - Переключить на трек влево
+ 15. Переключить на трек вправо - Переключить на трек вправо

- НЕ решено
+ решено

Пункты 11 и 12 начинают работать после выхода из ждущего режима (suspend) может эта информация ускорит поиск решения hmm

Не работает кнопка питания при нажатии на нее. На сколько я понимаю проблема в менеджере питания xfce4.


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
10.1 Перезапустите ноутбук/ПК и все должно заработать
10.2 Можно и этой командой перезапустить контроллер отвечающий за FN клавиши: systemctl disable acpid.service && systemctl enable acpid.service

Если из того, что у вас не работает что либо или хоите добавить свои клавиши, тогда краткий экскурс:
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
10.Перезапустите ноутбук/ПК и все должно заработать хотя можно и этой командой перезапустить контроллер отвечающий за FN клавиши: systemctl disable acpid.service && systemctl enable acpid.service
