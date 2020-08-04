# Arch Install on VMWARE

## Install Base Arch System

Boot into Live Arch USB and enter the command line

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

### Partition Drives

Create and format the HDD partitions to install Arch. Note that we'll use a 512M partition for EFI, and allocate all remaining space to the OS. We'll use a SwapFile rather than a Swap Partition.

```shell

# List drives
fdisk -l

# Format partitions - THIS ERASES ALL DATA

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

Format our newly created partitions

```shell
# Create EFI fs
mkfs.fat -F32 /dev/nvme0n1p1

# Create root fs
mkfs.ext4 /dev/nvme0n1p2
```

### Mount filesystems

Mount our new patitions

```shell
# Mount root
mount /dev/nvme0n1p2 /mnt

# Mount EFI
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
```

### Configure Mirrorlist

Configure the mirrorlist for Pacman to use. Note - this greatly speeds up the PacStrap process.

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

Install the base Arch System onto our new filesystem.

```shell
# Bootstrap system and install packages
pacstrap /mnt base base-devel linux linux-firmware dhcpcd sudo vi vim nano ssh

# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab
```

## Configure System

Now that the Arch OS is installed, let's configure it further before rebooting back into the system itself.

### Login and Configure

Change root (chroot) into the new system to configure it.

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

After rebooting (and removing installation media) we are inside our new system as root and can setup users and packages.

```shell

# Create new user
useradd -m -G wheel myUser

# Create passwd
passwd myUser

# Edit sudoers file and uncomment below line
# %wheel ALL=(ALL) ALL
visudo

# Reboot and login as new user
```

### Install core packages and software

```shell
sudo pacman -S git vi networkmanager openssh htop bat tmux man i3-gaps i3status i3lock termite code-oss firefox rofi ranger thunar feh ntpd
```

### Configure and connect to network

```shell
# Start netwprk manager on boot
systemctl enable dhcpcd.service

# Also start immediately
systemctl start dhcpcd.service
```

### Configure graphical environment

```shell
# List cards
lspci | grep -e VGA -e 3D

# Install drivers
sudo pacman -S xf86-video-vmware mesa open-vm-tools

systemctl enable vmtoolsd.service

# Also start immediately
systemctl start vmtoolsd.service

# Install display server
sudo pacman -S xorg-server xorg-xinit i3-gaps i3status

# Install default fonts
sudo pacman -S noto-fonts ttf-droid ttf-ubuntu-font-family ttf-fira-code ttf-ionicons

# If not using display manager add the below line to .bash_profile
startx

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

### Configure sound

```shell
# Install packages
sudo pacman -s alsa-utils

# Visually set audio levels
alsamixer

# Set up key bindings (add to i3 config)
bindsym XF86AudioRaiseVolume exec amixer set Master 5%+ && $refresh_i3status
bindsym XF86AudioLowerVolume exec amixer set Master 5%- && $refresh_i3status
bindsym XF86AudioMute exec amixer set Master toggle && $refresh_i3status
```

### Configure backlight

```shell
# Install package (check Arch wiki for other package options)
sudo pacman -S xbacklight

# Add keybindings to i3 config
bindsym XF86MonBrightnessUp exec xbacklight -inc 20
bindsym XF86MonBrightnessDown exec xbacklight -dec 20
```
