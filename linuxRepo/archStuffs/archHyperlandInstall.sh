#!/bin/bash

# Install Waybar and Rofi
sudo pacman -Syu --noconfirm hyprland git firefox waybar rofi exa gnome

# Install yay
mkdir ~/Downloads
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/Downloads
cd ~/Downloads/yay
makepkg -si

# Specify the directories
confDir = "~/.config"
tmp = "~/tmp"

# Check if the directory exists and then installs my configs accordingly
if [ -d "$confDir" ]; then
  mv confDir tmp
  git clone https://github.com/ceviche55/myConfigs.git confDir
  mv tmp/* confDir
  rm tmp
else
  git clone https://github.com/ceviche55/myConfigs.git confDir
fi

# Print installation completion message
echo "Script Successful, Enjoy your Arch Experience"

