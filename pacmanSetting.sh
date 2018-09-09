#!/bin/bash
cp /etc/pacman.conf /etc/pacman.conf.backup
echo 'copy pacman.conf to pacman.conf.backuo'
sed -id 's/#Color/Color/g' /etc/pacman.conf
echo 'enable pacman color susscess'
echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
echo 'add archlinuxfr repostory'