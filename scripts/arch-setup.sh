#!/usr/bin/env bash

sudo pacman -S alacritty i3-gaps feh

pacaur -S albert fundle-git fish ttf-dejavu vim firefox xorg-server xorg-xinit python-pip compton xterm network-manager-applet polybar pulseaudio keychain gnome-keyring 

mkdir -p ~/Documents ~/Downloads ~/Pictures ~/Desktop ~/git ~/Games ~/Iso

cp ~/.dotfiles/screenshots/active-background.jpg ~/Pictures/active-background.jpg

#Change shell to fish
chsh -s /usr/bin/fish
