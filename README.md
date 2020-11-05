# EN
These scripts together are used to install Gentoo linux:
 + `partitioning.py` -- wipes, makes lvm partitions on selected disk and *calls* `preinstall.py`. Accepts path to block device. Example: `python3 partitioning.py /dev/sda`
 + `preinstallation.py` -- disables ipv6 and downloads stage3 archive. Makes chroot to `/mnt/gentoo` and *calls* `installation.py`
 + `installation.py` -- selects profile (default -- desktop [20]), adds cpu flags and *calls* `compiling.py`
 + `compiling.py` -- updates world, installs Vim, kernel and grub. Configures `/etc/fstab`. *Calls* `environment_install.py`
 + `environment_install.py` -- installs my preferred apps and configures them. **Can be safely removed**

`download_scripts.sh` can easily download all scripts from above steps into `installation` folder


# RU

Данные скрипты используются для установки Gentoo linux:
 + `partitioning.py` -- очищает диск и создает lvm партиции на выбранном диске. *Вызывает* `preinstall.py`. Принимает путь до блочного устройства.
 Пример: `python3 partitioning.py /dev/sda`
 + `preinstallation.py` -- отключает ipv6 и скачивает stage3 архив. Делает chroot в `/mnt/gentoo` и *вызывает* `installation.py`
 + `installation.py` -- выбирает профиль (стандартный -- desktop [20]), добавляет флаги процессора и *вызывает* `compiling.py`
 + `compiling.py` -- обновляет мир, устанавливает Vim, ядро и grub. Настраивает `/etc/fstab`. *Вызывает* `environment_install.py`
 + `environment_install.py` -- устанавливает и конфигурирует лично мое программное окружение. **Спокойно можно удалить**

`download_scripts.sh` скачивает скрипты из шагов выше в папку `installation`
