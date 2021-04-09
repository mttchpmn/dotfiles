# Grub-themes

This folder contains custom grub themes.

## Installation

- Symlink the desired theme(s) to `/usr/share/grub/themes`
- Update the following line in `/etc/default/grub` to the path to the desired theme
  ```
  GRUB_THEME="/usr/share/grub/themes/my-theme-name/theme.txt"
  ```
- Run `sudo update-grub` to apply changes
- Reboot

## Grub graphics resolution

If the grub screen resolution is not right for your monitor, boot into the grub command line and run `vbeinfo` / `videoinfo` to see the list of supported display resolutions for your graphics card. Example: '3840x1080x32'

Update the following line in your grub config file:

```
GRUB_GFXMODE=3840x1080x32,auto

Run `sudo update-grub` to apply the changes
```
