**Рішення / Solution:** <br>
UA: Виконайте ці команди, щоб виправити проблему для поточної сесії. <br>
EN: Run these commands to fix the issue for the current session. <br>

```bash
# Знаходимо ID драйвера / Find driver ID
grep vboxguest /proc/misc
grep vboxuser /proc/misc

# Створюємо пристрій (замініть <ID> на номер) / Create device (replace <ID>)
sudo mknod /dev/vboxguest c 10 <ID>
sudo chmod 0666 /dev/vboxguest
sudo mknod /dev/vboxuser c 10 <ID>
sudo chmod 0666 /dev/vboxuser

# Перезапускаємо клієнт / Restart client
killall VBoxClient
VBoxClient --clipboard
VBoxClient --draganddrop
```

----------------------
UA: Налаштування автоматичного скрипта, який створює ноди при кожному завантаженні (після udev). <br>
EN: Setting up an automated script that creates nodes at every boot (after udev). <br>

📂 Файли / Files <br>
Поруч з цим документом знаходяться два файли: <br> <br>

- fix-vbox.sh — Bash-скрипт логіки. <br>
- vbox-fix.service — Systemd Unit для автозапуску. <br> <br>

Крок 1: Копіювання скрипта / Copy Script  <br>
UA: Скрипт розміщуємо в /usr/local/bin, оскільки це стандартне місце для користувацьких системних скриптів. <br>
EN: Place the script in /usr/local/bin as it is the standard location for user system scripts. <br>

```bash
sudo cp fix-vbox.sh /usr/local/bin/
```

Крок 2: Налаштування прав доступу / Set Permissions <br>
UA: Критично важливо надати права на виконання (+x або 755). Власником файлу має бути root. <br>
EN: It is critical to grant execution permissions (+x or 755). The file owner must be root. <br> <br>

```bash
sudo chmod 755 /usr/local/bin/fix-vbox.sh
sudo chown root:root /usr/local/bin/fix-vbox.sh
```

Крок 3: Встановлення сервісу / Install Service <br>
UA: Копіюємо файл сервісу та активуємо його. <br>
EN: Copy the service file and enable it. <br> <br>

```bash
sudo cp scripts/vbox-fix.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable vbox-fix.service
```

Крок 4: Перезавантаження / Reboot
```bash
sudo reboot
```
