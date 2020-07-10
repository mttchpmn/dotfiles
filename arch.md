# Arch Install on XPS 9570

## Installation

### Connect to wifi

```shell
# Get interface list
ip link

# Disable interface (needed for wifi-menu to work)
ip link set wlan0 down

# Connect to network
wifi-menu

# Verify connection
ping -c 3 archlinux.org
```

### Update System Clock

```shell
# Update clock
timedatectl set-ntp true

# Check service status
timedatectl status
```

### Partition Drive

```shell

# List drives
fdisk -l

# Format partitions - THIS ERASES ALL DATA
# Note - we'll use a 512M partition for EFI, give all remaining space to / and use a swapfile instead of swap partition

# Enter partitioning mode
fdisk /dev/nvme0n1

# Create GPT partition table
g

# Create new partition
n

# Set partition number (Use default)
1

# Set start block (Use default)
<enter>

# Set end block
+512M

# Change partition type
t

# Select EFI system
1

# Create root partition (use all defaults to take up all remaining space)
n

# Write changes to disk
w

# Verify
lsblk # Or fdisk -l
```

### Create Filesystem

```shell
# Create EFI fs
mkfs.fat -F32 /dev/nvme0n1p1

# Create root fs
mkfs.ext4 /dev/nvme0n1p2
```

### Mount filesystems

```shell
# Mount root
mount /dev/nvme0n1p2 /mnt

# Mount EFI
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
```

### Configure Mirrorlist

```shell
# Update pacman
pacman -Syy

# Install reflector
pacman -S reflector

# Backup mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# Configure mirrorlist to use NZ servers
reflector -c "NZ" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

### Install System

```shell
# Bootstrap system and install packages
pacstrap /mnt base linux linux-firmware sudo vim nano

# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab
```

## Configure System

### Login and Configure

```shell
# Change into new system
arch-chroot /mnt

# Set time zone
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime

# Run hwclock to generate /etc/adjtime
hwclock --systohc

# Setup locales
# Edit /etc/locale.gen and uncomment relevant locales
locale-gen

# Create locale.conf file and set Lang variable
echo LANG=en_US.UTF-8 >> /etc/locale.conf

# Set hostname
echo myHostname >> /etc/hostname

# Edit hosts file and add the following lines (not commented out)
vim /etc/hosts
# 127.0.0.1	    localhost
# ::1		        localhost
# 127.0.1.1	    myhostname.localdomain	myhostname

# Set root password
passwd

# Install packages needed for wifi setup
pacman -S networkmanager
```

### Install Boot Loader

```shell
# Install packages
pacman -S grub efibootmgr

# Install GRUB
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB

# Make GRUB config
grub-mkconfig -o /boot/grub/grub.cfg
```

### Exit and reboot

```shell
# Exit chroot
exit

# Unmount partitions
umount -R /mnt
```

### Setup New System

```shell

# Create new user
useradd -m -G wheel myUser

# Create passwd
passwd myUser

# Edit sudoers file and uncomment below line
# %wheel ALL=(ALL) ALL
visudo

# Reboot and login as new user

# Install missing packages
sudo pacman -S git vi openssh htop bat tmux man

# Start netwprk manager on boot
systemctl enable NetworkManager.service

# List wifi networks
nmcli device wifi list

# Connect to wifi
nmcli device wifi connect myNetwork password myPassword

# Install graphical environment

# List cards
lspci | grep -e VGA -e 3D

# Install drivers
sudo pacman -S xf86-video-intel
sudo pacman -S xf86-video-nouveau # NVIDIA

# Install display server and wm
sudo pacman -S xorg-server xorg-xinit xrdb i3-gaps i3status

# Install and start display manager (optional)
sudo pacman -s lightdm lightdm-gtk-greeter
systemctl enable lightdm

# If not using display manager add the below line to .bash_profile
startx

# Configure for hidpi
echo "Xft.dpi: 192" > ~/.Xresources

# Load Xresources on startup
echo "[ -f ~/.Xresources ] && xrdb -merge -I $HOME ~/.Xresources" >> .xinitrc

# Add i3 to .xinitrc
echo "exec i3" >> ~/.xinitrc

```

Start X on login

Add below to .bash_profile

```
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
```
