# Ubuntu 18.04 Installation on XPS 9570

* Useful Resources:
  * Respun ISO: https://github.com/JackHack96/dell-xps-9570-ubuntu-respin
  * https://www.dell.com/support/article/nz/en/nzdhs1/sln301754/how-to-install-ubuntu-and-windows-8-or-10-as-a-dual-boot-on-your-dell-pc?lang=en
  * https://medium.com/@peterpang_84917/personal-experience-of-installing-ubuntu-18-04-lts-on-xps-15-9570-3e53b6cfeefe
  * https://medium.com/@pwaterz/how-to-dual-boot-windows-10-and-ubuntu-18-04-on-the-15-inch-dell-xps-9570-with-nvidia-1050ti-gpu-4b9a2901493d
  * https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)
  * https://askubuntu.com/questions/61396/how-do-i-install-the-nvidia-drivers


## Configure fresh Windows Install

* Update drivers and BIOS
  * Download Dell Update Utility from Dell website
* Disable 'Fast Startup'
  * Control Panel > Power Options > Change what the power buttons do
  * 'Change Settings that are unavailable' > Disable Fast Startup (Lets Ubuntu see Win partition later)

## Configure BIOS

_NB: Save BIOS changes as 'Custom User Settings', as this makes the changes easier to revert_

* Change SSD from 'Raid On' to 'AHCI' (Lets Ubuntu see the SSD)
  * In Windows, run CMD as admin:
  ```bcdedit /set {current} safeboot minimal```
  * Restart into BIOS
  * System Configuration > SATA Operation > AHCI
  * Save as Custom user setting (Easier to reset)
  * Exit and login in to Windows as normal
  * In Admin CMD:
  ```bcdedit /deletevalue {current} safeboot```

* Set BIOS to UEFI
  * General > Boot Sequence > UEFI

* Disable Legacy Option ROMS
  * General > Advanced Boot Options > Enable Legacy Option ROMS

* Enable UEFI Network Stack
  * General > Advanced Boot Options > Enable UEFI Network Stack

* Disable secure boot
  * Secure Boot > Secure Boot Enable > Disable

* Disable Thunderbolt auto-switch (Stops the warning message on reboot)
  * System Configuration > Thunderbolt Auto Switch > Disable Auto Switch
  * Select 'BIOS Assist Enumeration' (Ubuntu was switching to this already)

## Create Bootable Ubuntu USB

* Download JackHacks Ubuntu Respun ISO
  * https://github.com/JackHack96/dell-xps-9570-ubuntu-respin

* Use Rufus to create bootable USB
  * Use 'GPT' for partition Options

## Boot into Ubuntu USB

_NB: If using respun ISO from JackHack96 above, it should work out of the box, if not, you will need to add the 'nomodeset' line as below_

* Restart, and tap F12 after boot to get into boot menu 
* Select Ubuntu USB
* Select 'Try Ubuntu without installing'
  * IF NOT USING RESPUN ISO:
  * Hover over 'Try Ubuntu...' option and press 'e'
  _https://www.dell.com/support/article/nz/en/nzdhs1/sln306327/manual-nomodeset-kernel-boot-line-option-for-linux-booting?lang=en_
  * Add 'nomodeset' after the words 'quiet splash', otherwise Ubuntu will not boot properly, and you will get a black screen requiring hard reset
  * You will need to do this on every reboot until manually editing GRUB config
  * Note that on subsequent reboots, you should add 'nouveau.modeset=0' instead of 'nomodeset'

* Launch Ubuntu Installer on desktop
* Continue as normal
* Select 'Enable Insecure Boot Mode' should you have the option (Doesn't appear with respun ISO)

## Boot into Ubuntu as normal and configure OS

* You'll be greeted with a 'What's New' dialog
  * Follow through and setup LivePatch

* Run JackHack96 post-install tweaks 
  * ```bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"```

* Configure GRUB
  * Open terminal with Ctrl+Alt+T
  * Run ```sudo gedit /etc/default/grub```
    * If NOT using respun ISO:
      * Change the line 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' to 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nouveau.modeset=0"'
      * Respun ISO doesn't appear to need this

    * Prevent laptop getting hot when using Intel GPU on suspend (may not be needed)
      * Add "nouveau.modeset=0 mem_sleep_default=deep nouveau.runpm=0" to the end of "GRUB_CMDLINE_LINUX_DEFAULT" line

    * Decrease resolution to make text more readable
      * Uncomment the line '#GRUB_GFXMODE=640x480'
      * Set it to desired resolution - etc '1024x768'
      * Comment out the line 'GRUB_TERMINAL=console'

    * Add background to GRUB
      * Add line 'GRUB_BACKGROUND="/boot/grub/grub_bg.png"'
      * Add bg file at specified path
  
    * Save file and run ```sudo update-grub```
    * Reboot

* Install graphics drivers (Already done if using post install script above)
  * Add Graphics drivers repository
  * In terminal run: ```sudo add-apt-repository ppa:graphics-drivers/ppa```
  * ```sudo apt-get update```
  * Use ```sudo prime-select intel``` or ```sudo prime-select nvidia``` to switch cards (reboot required)
  * When running Nvidia card, run ```nvidia smi``` to see GPU info

* Improve battery life
  * Run:
  ```
  sudo apt install update
  sudo apt install tlp tlp-rdw powertop
  sudo tlp start
  sudo powertop --auto-tune
  sudo reboot
  ```

* Fix touchpad (may be needed if cursor jumps around while typing)
  * Run:
  ```
  sudo apt-get install xserver-xorg-input-libinput
  sudo apt-get remove --purge xserver-xorg-input-synaptics
  sudo reboot 
  ```

* Add multi-touch gestures (optional)
  * Enable / install build-essential (https://askubuntu.com/questions/398489/how-to-install-build-essential)
  * Run:
  ```
  sudo apt git install xdotool wmctrl libinput-tools
  sudo gpasswd -a $USER input
  gpasswd -a [your-user-name] input
  cd ~/Downloads
  git clone git@github.com:bulletmark/libinput-gestures.git
  cd libinput-gestures
  sudo ./libinput-gestures-setup install
  libinput-gestures-setup autostart
  libinput-gestures-setup start
  ```
  * The default gestures are in /etc/libinput-gestures.conf. If you want to create your own custom gestures then copy that file to ~/.config/libinput-gestures.conf and edit it.

## User setup

* Tweak your new OS as desired


