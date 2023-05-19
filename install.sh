#!/bin/sh

# Packages to install
sudo pacman -Syu --noconfirm alacritty rofi neovim helix lf zathura firefox lxappearance picom exazsh nnn 

# Configs to set up
cp -ra cfg/. ~/.config
cp -ran fonts/. ~/.fonts
cp -ra home/. ~/

# Sets up Nvim with packer bootstrap command
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# PowerLevel10k theme install
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install yay
mkdir ~/Downloads
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/Downloads/yay
cd ~/Downloads/yay
makepkg -si
cd ~

