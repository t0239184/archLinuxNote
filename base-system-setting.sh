#!/bin/bash
echo 'genfstab start...'
genfstab -U /mnt | sed -e 's/relatime/noatime/g' >> /mnt/etc/fstab && echo 'genfstab Susscess!!'

echo 'arch-chroot start...'
arch-chroot /mnt && echo 'arch-chroot Susscess!!'

echo 'Date and Time Setting...'
sed -i -e 's/^#\(en_US\|zh_TW\)\(\.UTF-8\)/\1\2/g' /etc/locale.gen && locale-gen && echo "LANG=en_US.UTF-8" > /etc/locale.conf && echo 'set Date and Time Susscess!!'

echo 'TimeZone Setting...'
export TIMEZONE=Asia/Taipei && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && hwclock --systohc && systemctl enable systemd-timesyncd && echo 'TimeZone Susscess!!'

echo 'Computer name Setting...'
export HOSTNAME=archpc && echo $HOSTNAME > /etc/hostname && sed -ie "8i 127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" /etc/hosts && echo 'Computer name Susscess!!'

echo 'Systemctl Enable Service...'
systemctl enable dhcpcd && echo 'enable dhcpcd Susscess!!'
systemctl enable NetworkManager && echo 'enable NetworkManager Susscess!!'
systemctl start NetworkManager && echo 'start NetworkManager Susscess!!'

echo 'mkinitcpio Start...'
mkinitcpio -p linux && echo 'mkinitcpio Susscess!!'

echo 'install refind-efi...'
pacman -S refind-efi && echo 'install refind-efi Susscess!!'
refind-install && echo 'refind-install Susscess!!'

echo 'Not create user!!!'

