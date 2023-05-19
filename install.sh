#!/bin/sh

# Packages to install
sudo pacman -Syu --noconfirm alacritty rofi neovim helix lf zathura firefox lxappearance picom exazsh

# Configs to set up
cp -ra cfg/. ~/.config
cp -ran fonts/. ~/.fonts
cp -ra home/. ~/

# Sets up Nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
