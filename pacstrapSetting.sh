#!/bin/bash
pacstrap /mnt base base-devel
pacstrap /mnt intel-ucode
pacstrap /mnt zsh gvim rsync htop wget git openssh networkmanager dialog iw dhclient wpa_supplicant
pacstrap /mnt python noto-fonts noto-fonts-cjk
