#!/bin/bash

# Install Waybar and Rofi
sudo pacman -Syu --noconfirm awesomewm alacritty rofi neovim helix lf zathura firefox lxappearance picom exa

# Install yay
mkdir ~/Downloads
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/Downloads
cd ~/Downloads/yay
makepkg -si
cd ~

# Specify the directories
confDir = "$HOME/.config"
tmp = "$HOME/tmp"

# Check if the directory exists and then installs my configs accordingly
if [ -d "$confDir" ]; then
  mv "$confDir" "$tmp"
  cp -rs cfg/* "$confDir"
  mv "$tmp"/* "$confDir"
  rm -r "$tmp"
    
else
  cp -rs cfg/* "$confDir"
fi

cp -rs fonts ~/.fonts
cp -rs home ~/

# Print installation completion message
echo "Script Successful, Enjoy your Arch Experience"
