#!/usr/bin/env bash

pacaur -S alacritty-git rofi ttf-dejavu vim firefox xorg-server xorg-xinit python-pip compton xterm termite i3 network-manager-applet polybar pulseaudio keychain gnome-keyring 

#Install fundle
curl -sfL https://git.io/fundle-install | fish

#Change shell to fish
chsh -s /usr/bin/fish
