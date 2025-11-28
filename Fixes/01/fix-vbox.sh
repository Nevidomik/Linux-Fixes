#!/bin/bash
# UA: Скрипт для динамічного пошуку ID та створення нод
# EN: The script to dynamically find the driver ID and create the nodes

# Delay to avoid race conditions with udev
sleep 5

id_guest=$(grep vboxguest /proc/misc | awk '{print $1}')
id_user=$(grep vboxuser /proc/misc | awk '{print $1}')

# Якщо ID знайдено і файли ще не існують - створюємо їх
if [ ! -z "$id_guest" ] && [ ! -e /dev/vboxguest ]; then
    mknod /dev/vboxguest c 10 $id_guest
    chmod 0666 /dev/vboxguest
fi

if [ ! -z "$id_user" ] && [ ! -e /dev/vboxuser ]; then
    mknod /dev/vboxuser c 10 $id_user
    chmod 0666 /dev/vboxuser
fi