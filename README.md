
# ArchLinuxNote #


## Install guide
#### [for Mac]
    $ diskUtil list                    //列出所有的磁碟
    $ diskUtil unmountDisk [usbDisk]   //卸載磁碟

#### [Live USB]
    $ dd bs=4m if=[isoFile] for=[usbDisk]

#### [for ASUS]
Reboot > F2 > EFI > Boot > first USB > Save and Exit

#### [Arch Grub Welcome page]
hit 'e' on 'Arch install' add 'pci=nomsi' and 'modprobe.blacklist=nouveau'

#### [Check boot mode]
    efivar -l         //如果為錯誤訊息則為BIOS啟動非EFI


## Format
#### [硬碟分割]
    $ lsblk           //檢查目前硬碟分割情況
    $ cgdisk /dev/sda //GPT分割表用cgdisk分割
    
    BOOT:200M   -> sda2
    ROOT:20G    -> sda4
    SWAP:24G    -> sda3
    OPT :5G     -> sda5
    TMP :1G     -> sda6  
    USR :10G    -> sda7  
    VAR :5G     -> sda8  
    HOME:512G   -> sda9
    
    USR : Unix-Software-Resouse
    TMP : Template
    VAR : Varible
    
<br/>

    $ lsblk           //檢查目前硬碟分割情況

#### [初始化分割區]
    $ mkfs.fat -F32 /dev/sda2  //EFI
    $ mkswap /dev/sda3         //SWAP

    $ mkfs.ext4 /dev/sda4
    $ mkfs.ext4 /dev/sda5
    $ mkfs.ext4 /dev/sda6
    $ mkfs.ext4 /dev/sda7
    $ mkfs.ext4 /dev/sda8
    $ mkfs.ext4 /dev/sda9

#### [掛載分割區]
    $ mkdir /mnt/home /mnt/boot/ /mnt/boot/efi
    $ mount /dev/sda4 /mnt                                //掛載ROOT至/mnt
    $ mount /dev/sda9 /mnt/home                           //掛載HOME至/mnt/home
    $ mount /dev/sda2 /mnt/boot/efi                       //(EFI)掛載BOOT至/mnt/boot/efi
    $ mount /dev/sda2 /mnt/boot                           //(BIOS)掛載BOOT至/mnt/boot/
    $ swapon /dev/sda3                                    //啟用SWAP


## NetWork
#### [Wireless]
    $ wifi-menu
    
#### [Wireless2]
    $ ip link                                             //顯示網路介面
    $ ip link set [interface] up                          //啟用介面
    $ iw [interface] link                                 //確認無線裝置連線狀態
    $ iw [interface] scan | grep SSID                     //掃描WIFI訊號，只顯示SSID
    $ wpa_passphrase [WIFI-SSID] >> /tmp/wifi.conf        //連線到WPA/WPA2加密的無線網路，會等待使用者輸入密碼
    $ cat /tmp/wifi.conf                                  //印出上面產生的檔案內容
    $ wpa_supplicant -B -i [interface] -c /tmp/wifi.conf  //連線
    $ iw [interface] link                                 //確認無線裝置連線狀態
    $ dhclient wlan0                                      //要求DHCP伺服器配發動態IP
    $ ping -c 3 8.8.8.8                                   //測試連線

#### [ethnet]
    $ ip link set [interface] up                          //啟用介面
    $ dhcpcd [interface]                                  //要求DHCP伺服器配發動態IP

#### [Net By Usb]
    $ ip link set [interface] up
    $ dhcpcd [interface]


## Pacman
##### package manager, command and application and...
#### [Pacman Mirrorlist config setting]
    $ cp mirrorlist mirrorlist.backup                     //備份鏡像清單
    $ rankmirrors -n 6 mirrorlist.backup > mirrorlist.    //讓系統測試鏡像速度，按速度排序鏡像，此步驟需要一些時間

#### [Pacman config setting]
    $ cp /etc/pacman.conf /etc/pacman.conf.backup.        //備份設定檔
    $ sed -id 's/#Color/Color/g' /etc/pacman.conf。       //開啟色彩
    $ echo -e "[ArchLinuxfr]\nSigLevel = Never\nServer = http://repo.ArchLinux.fr/$arch" >> /etc/pacman.conf  ////Pacman新增Reporsitory


## Download and Install base system
#### [Update pacman repostory]
    $ pacman -Syy

#### [Install packages]
    $ pacstrap /mnt

>base base-devel intel-ucode
zsh vim rsync htop
wget git openssh networkmanager dialog iw dhclient wpa_passphrase wpa_supplicant
pythod yaourt noto-fonts noto-fonts-cjk

#### [System config setting]
    $ genfstab -U /mnt | sed -e 's/relatime/noatime/g' >> /mnt/etc/fstab   //開機時的設定檔，開機時會依這個檔案的內容掛載檔案系統。
    $ blkid                                                                //顯示各磁碟資訊
    $ vim /mnt/etc/fstab                                                   //確認UUID是否正確（和 blkid 比對）

#### [Into System]
    $ arch-chroot /mnt /bin/bash

#### [Language]
    $ sed -i -e 's/^#\(en_US\|zh_TW\)\(\.UTF-8\)/\1\2/g' /etc/locale.gen     //en_US.UTF-8 和 zh_TW.UTF-8 的註解拿掉
    $ locale-gen
    $ echo "LANG=en_US.UTF-8" > /etc/locale.conf

#### [Date and Time]
    $ export TIMEZONE=Asia/Taipei
    $ ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    $ hwclock --systohc
    $ systemctl enable systemd-timesyncd

#### [Computer name]
    $ export HOSTNAME=<hostname>
    $ echo $HOSTNAME > /etc/hostname
    $ sed -ie "8i 127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" /etc/hosts

#### [Auto Service controller]（systemctl）
    $ systemctl enable fstrim.timer                                         //有SSD才需要，啟用每週執行 fstrim
    $ systemctl enable NetworkManager

    $ systemctl enable dhcpcd                                               //啟動dhcp網路
    $ systemctl enable NetworkManager
    $ systemctl start NetworkManager

#### [建立開機映像]
Creates an initial ramdisk environment for booting the linux kernel

    $ vim /etc/mkinitcpio.conf                                              //(optional) 看有沒有要修改
    $ mkinitcpio -p linux


以下有常用的開機模式為GRUB和rEFind

#### [GRUB]
    $ pacman -S grub os-prober efibootmgr
    $ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch --recheck
    $ grub-mkconfig -o /boot/grub/grub.cfg                                  //建立grub開機設定檔

#### [rEFind]
    $ pacman -S refind-efi
    $ refind-install
    $ vim /boot/refind_linux.conf                                             //設定配置文件/boot/refind_linux.conf内核参数
refind_linux.conf

> "Boot with standard options"  "root=UUID=<your uuid of root partition> rw quiet acpi_rev_override=1 initrd=/boot/initramfs-linux.img initrd=/boot/intel-ucode.img enable_psr=1 disable_power_well=0 nvme_core.default_ps_max_latency_us=130000"

> "Boot to single-user mode"    "root=UUID=<your uuid of root partition> rw quiet acpi_rev_override=1 single"

> "Boot with minimal options"   "ro root=/dev/<your root partition name>"


#### [Create User]
    $ sed -ie 's/# \(%wheel ALL=(ALL) ALL\)/\1/' /etc/sudoers
    $ export USERNAME=<username>
    $ useradd -mG wheel,storage,power,video,audio $USERNAME //加上 -m 參數才會建立使用者家目錄以及 .bash 相關檔案
    $ passwd $USERNAME # 設定密碼
    $ exit
    $ reboot

双系统直接进windows的话，请在windows下使用easyuefi禁用windows boot manager

GUI-Desktop
> Gnome
> KDE
> XFCE
> ...

#### [Install GUI Desktop-Gnome]
    $ sudo pacman -S gnome

#### [Gnome-extra]
    $ sudo pacman -S atomix dconf-editor devhelp gnome-nettool gnome-weather gnome-builder gnome-chess gnome-usage gnome-tweaks gnome-recipes quadrapassel sysprof vinagre
    $ sudo pacman -Rsc epiphany gdm gedit gnome-documents gnome-music gnome-screenshot gnome-terminal sushi


    $ sudo pacman -S xorg-xinit xorg-server xorg-xclock xterm xorg-twm
    $ vim /etc/X11/xinit/xinitrc

/etc/X11/xinit/xinitrc                                                   //註解以下內容

>\#twm &
>\#xclock -geometry 50x50-1+1 &
>\#xterm -geometry 80x50+494+51 &
>\#xterm -geometry 80x20+494-0 &
>\#exec xterm -geometry 80x66+0+0 -name login
>
>exec gnome-session                                                      //如果你使用的是gnome桌面，添加上這行

    $ cp /etc/X11/xinit/xinitrc ~/.xinitrc           //可以使用別的身份登入，為用户複製一份單獨的配置文件，開啟個別的桌面系統
    $ startx


------------------------------------------------------------------
#### [Install Desktop Manager]
    $ pacman -S gdm
    $ sed -ie 's/#\(WaylandEnable\)/\1/' /etc/gdm/custom.conf

#### [Automatically Open]
    $ systemctl enable gdm                                                  //設定gdm開機自動啟動載入gnome桌面
#### [Manually Open]
    $ systemctl start gdm                                                   //手動開啟gdm
------------------------------------------------------------------


#### [Terminal]
    $ pacman -S roxterm

#### [FileSystem Support]
    $ pacman -S ntfs-3g dosfstools                                           //Support NTFS and Exfat fileSystem

#### [YAOURT-PackageManager]
    $ sudo pacman -S --needed base-devel git wget yajl
    $ cd /tmp
    $ git clone https://aur.archlinux.org/package-query.git
    $ cd package-query/
    $ makepkg -si && cd /tmp/
    $ git clone https://aur.archlinux.org/yaourt.git
    $ cd yaourt/
    $ makepkg -si

#### [Change Folder name to Englist]
    $ sudo vim .config/user-dirs.dirs

#### [Gnome-Theme]
    $ yaourt -S osx-arc-darker
    $ yaourt -S osx-arc-shadow
    $ yaourt -S x-arc-darker
    $ yaourt -S x-arc-shadow

#### [Gnome-extend from yaourt]
    $ yaourt -S gnome-shell-extension-dash-to-dock
    $ yaourt -S gnome-shell-extension-arc-menu-git
    $ yaourt -S gnome-shell-extension-cpufreq-git

#### [Gnome-extend from gnome-store]
>alternatetab
>custom hot corners
>extend panel menu
>removeable drive menu
>user themes
>workspace indicator

#### [Font]
    $ yaourt -S ttf-droid              //Window Font
    $ yaourt -S ttf-ubuntu-font-family  //Terminal Font


### [InputMethod]
    $ sudo pacman -S gcin
    $ vim ~/.xinitrc

~/.xinitrc
> export LANG="zh_TW.UTF-8"
> export LC_CTYPE="zh_TW.UTF-8"
> export XMODIFIERS=@im=gcin
> export GTK_IM_MODULE="gcin"
> export QT_IM_MODULE="gcin"
> gcin &

#### [Office]
    $ yaourt -S wps-office

#### [Music-Player]
    $ sudo pacman -S audacious

#### [Video-Player]
    $ sudo pacman -S vlc



## Develop
#### [Java]
    $ sudo pacman -S jdk8-openjdk
    $ cd /bin && ll | grep java   //Check java folder real path
    $ echo export JAVA_HOME=\"/usr/lib/jvm/default-runtime\" >> ~/.zshrc
    $ echo export PATH=\"'$JAVA_HOME/bin/:$PATH'\"
    $ source ~/.zshrc

#### [Change JDK Version]
    $ archlinux-java status

>Available Java environments:
>  java-10-openjdk
>  java-8-openjdk (default)

    $ archlinux-java get
    $ archlinux-java set <JDK version>


#### [Maven]
    $ sudo pacman -S maven
    $ cd /bin && ll | grep mvn   //Check maven folder real path
    $ echo export MAVEN_HOME=\"/opt/maven\" >> ~/.zshrc
    $ echo export PATH=\"'$MAVEN_HOME/bin/:$PATH'\"
    $ source ~/.zshrc

#### [JetBrain]
    $ yaourt -S intellij-idea-ultimate-edition //Java ide

Plugin:
    -jRebel for Intellij

Theme:
    -Ladies Night 2

Font:
    -Yahei Mono
    -Noto Sans Mono

## jRebel Crack
    https://github.com/ilanyu/ReverseProxy/releases/tag/v1.4

    Download:
    Mac    > ReverseProxy_darwin_amd64
    Linux  > 

1.執行
    $ chmod 777 ReverseProxy_darwin_amd64
    $ $bash ReverseProxy_darwin_amd64

2.idea setting
Open idea Setting > jRebel  choise Licence option

    "http://127.0.0.1:8080/xin"        //port號後隨意填
    "aaa@aaa.com"                      //只要填入合格mail格式即可

### Don't close terminal
3.switch work offline
如果之後到期後再執行一次整個流程

https://www.jianshu.com/p/8ce60dd452f4

#### [DataGrip]
    $ yaourt -S datagrip                    //DataBase ide

#### [JetBrain Creck]
    sudo vim /etc/hosts
hosts
> 
> 
> 



## Graphy Card
#### [Arch Disable Nvidia]
bbswitch can help you to disable Nvidia(PowerOff), First need install bbswitch

    $ sudo pacman -S bbswitch dkms bumblebee
    $ sudo echo "bbswitch" >> /etc/modules-load.d/modules.conf                  //run bbswitch of system load module
    $ sudo echo "options bbswitch load_state=0" >> /etc/modprobe.d/bbswitch.conf //set disable nouveau option of system load module
    $ sudo echo "blacklist nouveau" >> /etc/modprobe.d/nouveau_blacklist.conf    //set nouveau to blacklist
    $ mkinitcpio -p linux                                                  //rebuild initrd
    $ reboot
    $ lspci | grep NVIDIA            //if Nvidia status show (rev ff), is sucesses!!


#### [Touchpad config]
    $ xinput list                                      //show all input drive, and search you touchpad
    $ xinput list-props [driveId]                       //input your touchpad Id

>Device 'SynPS/2 Synaptics TouchPad':
>      Device Enabled (139):   1
>      Coordinate Transformation Matrix (141): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
>      libinput Tapping Enabled (274): 0
>      libinput Tapping Enabled Default (275): 0
>      libinput Tapping Drag Enabled (276):    1
>      ...

    $ xinput set-prop 12[driveId] 274[propertiesId] 1[value]
or

    $ xinput set-prop --type=int --format=8 "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1


#### [TouchPad multiple config]
    $ sudo pacman -S xf86-input-libinput
    $ cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/30-touchpad.conf  //Setting touchpad, "/usr/share" is default config, "/etc/" is user custom config
    $ sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
30-touchpad.conf

>Section "InputClass"
>        Identifier "libinput touchpad catchall"
>        MatchIsTouchpad "on"
>        MatchDevicePath "/dev/input/event*"
>        Driver "libinput"
>        Option "Tapping" "on"
>        Option "TapButton1" "1"
>        Option "TapButton2" "3"
>        Option "TapButton3" "2"
>        Option "VertEdgeScroll" "on"
>        Option "VertTwoFingerScroll" "on"
>        Option "HorizEdgeScroll" "on"
>        Option "HorizTwoFingerScroll" "on"
>        Option "NaturalScrolling" "on"
>EndSection




Ref: https://itw01.com/MSCQE8K.html


#### [Show System temp]
    $ sudo pacman -S psensor



#### [Quick lancer]
    $ yaourt -S albert

#### [Run Windows exe file]
    $ sudo pacman -S wine


# System Setting

#### [SATA enable AHCI mode]
SATA-MODE：IDE(Default) or AHCI
now, Linux and Windows supported AHCI
Native AHCI mode 提供更好的性能（如热插拔和 NCQ 支持）、模拟的 IDE 模式提供更好的兼容性。

    $ sudo vim /etc/mkinitcpio.conf
mkinitcpio.conf

>MODULES="ahci"


    $ mkinitcpio -p linux                             //rebuild
    $ dmesg                                          //if find 'AHCI' and 'NCQ' then susscess

>...
>SCSI subsystem initialized
>libata version 3.00 loaded.
>ahci 0000:00:1f.2: version 3.0
>ahci 0000:00:1f.2: irq 24 for MSI/MSI-X
>ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x10 impl SATA mode
>ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part ems apst
>scsi host0: ahci
>scsi host1: ahci
>scsi host2: ahci
>scsi host3: ahci
>scsi host4: ahci
>scsi host5: ahci
>...
>ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
>...

#### [Power-Manager]
    $ sudo pacman -S tlp tlp-rdw
    $ sudo vim /etc/default/tlp       //custom your setting
    $ sudo tlp stat
    $ sudo systemctl enable tlp.service


# 
#### [sublime support chinese inputmethod]
    $ sudo pacman -S sublime-text-dev
    $ git clone https://github.com/lyfeyaj/sublime-text-imfix.git
    $ cd sublime-text-imfix
    $ sudo cp ./lib/libsublime-imfix.so /opt/sublime_text/
    $ sudo cp ./src/subl /usr/bin/
    $ touch ~/sublime && vim sublime
    
sublime

>\#!/bin/bash
>LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so subl

    $ bash ~/sublime

#### [GitHub]
    $ git config --global user.name "username"
    $ git config --global user.email "username@example.com"
    $ sudo pacman -S openssh
    $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"      //General SSH key
    $ ssh-agent -s                                           //Check ssh-agent can run
    $ ssh-add ~/.ssh/id_rsa                                   //Add SSH key：
1.Copy ~/.ssh/id_rsa.pub Text
2.GitHub > Settings > Personal settings > SSH Keys > Add key > Paste key

#### [Arch use bbswitch彻底禁用双显卡笔记本的独立显卡]
ref:  https://xuchen.wang/archives/archbbswitch.html

    $ modprobe bbswitch
    $ rmmod bbswitch  //bbswitch模块卸载
    $ cat /proc/acpi/bbswitch //查看其独立显卡运行状态。
    $ tee /proc/acpi/bbswitch \<\<\<\ OFF //关闭/开启独立显卡的指令为
    $ tee /proc/acpi/bbswitch \<\<\<\ ON  //关闭/开启独立显卡的指令为

if exec OFF but status is ON, Maybe Nvidia card not close yet

    $ dmesg | tail -1
    
>    bbswitch: device 0000:01:00.0 is in use by driver 'nouveau', refusing OFF
    
    $ rmmod nouveau                                         //驱动nouveau模块卸载
 

First，bbswitch has two parameter，load_state and unload_state

    $ modprobe bbswitch load_state=0                         //加载时使用
    $ echo 1 | tee /sys/module/bbswitch/parameters/unload_state //卸载时使用
    $ modprobe bbswitch load_state=0 unload_state=1
    $ sudo touch /etc/modprobe.d/bbswitch.conf && sudo vim /etc/modprobe.d/bbswitch.conf

/etc/init/bbswitch.conf

>description "Save power by disabling nvidia on Optimus"
>author "Lekensteyn <lekensteyn@gmail.com>"
>start on runlevel [2345]
>stop on runlevel [016]
>pre-start exec /sbin/modprobe bbswitch load_state=0 unload_state=1
>pre-stop exec /sbin/rmmod bbswitch


Arch Linux use 'systemd', so we create new service enable Nvidia at before shotdown

    $ sudo touch /etc/systemd/system/poweroff-enable-nvidia.service
    $ sudo vim /etc/systemd/system/poweroff-enable-nvidia.service

poweroff-enable-nvidia.service

>[Unit]
>Description=Enable NVIDIA card when poweroff
>DefaultDependencies=no
>
>[Service]
>Type=oneshot
>ExecStart=/bin/sh -c 'echo ON > /proc/acpi/bbswitch'
>
>[Install]
>WantedBy=shutdown.target


    $ systemctl enable --now             //enable bbswitch service
    $ sudo touch /etc/modules-load.d/bbswitch.conf
    $ sudo vim /etc/modules-load.d/bbswitch.conf
/etc/modules-load.d/bbswitch.conf

>\# Load bbswitch at boot
>bbswitch


    $ sudo touch /etc/modprobe.d/blacklist.conf
    $ sudo vim /etc/modprobe.d/blacklist.conf
/etc/modprobe.d/blacklist.conf

>blacklist nouveau

------------------------

# ERROR MESSAGE
##### 裝機案例：ASUS X550V
##### 錯誤問題：解決lspci timeout error
##### 錯誤訊息：lspci timeout
##### 解決方法：Disable Nvidia driver : Choosing arch from the ISO boot menu hit 'e' and add 'modprobe.blacklist=nouveau' to the kernal parameters
##### 參考相關：
ArchLinux将nvidia driver替换成开源的nouveau解决显卡驱动问题 http://gccpacman.com/2015/11/07/replace-nvidia-driver-with-nouveau-driver-arch-linux
NVIDIA (简体中文) https://wiki.archlinux.org/index.php/NVIDIA_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

##### 錯誤問題：pcieport / RTL8821AE錯誤
##### 錯誤訊息：error msg loop

>00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #6 (rev f1) (prog-if 00 [Normal decode])
>    Flags: bus master, fast devsel, latency 0, IRQ 124
>    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0

##### 解決方法：Choosing arch from the ISO boot menu hit 'e' and add 'pci=nomsi' to the kernal parameters


##### 錯誤問題：開機時有出現一行錯誤訊息
##### 錯誤訊息：Failed to start Load Kernel Modules
    $ systemctl status systemd-modules-load.service
>...
>Failed to find module 'option bbswitch load_state=0'
>...
