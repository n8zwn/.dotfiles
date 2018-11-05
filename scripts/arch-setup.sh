#!/usr/bin/env bash

sudo cp ~/.dotfiles/scripts/bin/* /usr/bin/

./install-pacaur

sudo pacman -S xss-lock alacritty i3-gaps feh

pacaur -S albert fundle-git fish ttf-dejavu vim firefox xorg-server xorg-xinit python-pip compton xterm network-manager-applet polybar pulseaudio keychain gnome-keyring i3lock-fancy-git 

mkdir -p ~/Documents ~/Downloads ~/Pictures ~/Desktop ~/git ~/Games ~/Iso

cp ~/.dotfiles/screenshots/active-background.jpg ~/Pictures/active-background.jpg

#Screensaver stuff
sudo cp ~/.dotfiles/config/systemd/user/suspend@.service /etc/systemd/system/
sudo systemctl enable suspend@"$USER".service


#Change shell to fish
chsh -s /usr/bin/fish
