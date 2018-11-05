#!/usr/bin/env bash

# Update Cached sudo credentials
echo "Updating cached sudo credentials"
sudo -v

sudo cp ~/.dotfiles/scripts/bin/* /usr/bin/

echo "Installing trizen"
./install-trizen

#Core dependencies
#sudo pacman -S xss-lock alacritty i3-gaps feh

#AUR dependencies
#pacaur -S albert fundle-git fish ttf-dejavu vim firefox xorg-server xorg-xinit python-pip compton xterm network-manager-applet polybar pulseaudio keychain gnome-keyring i3lock-fancy-git 


if command -v trizen 
then
	echo "Installing updates"
	trizen -Syu
	echo "Installing from pkgs file"
	trizen -S "$(cat ~/.dotfiles/scripts/pkgs | sed 's/\\n/\n/g')" --noconfirm
fi	


#Usual Desktop folders
mkdir -p ~/Documents ~/Downloads ~/Pictures ~/Desktop ~/git ~/Games ~/Iso

#Wallpaper
cp ~/.dotfiles/wallpapers/active-background.jpg ~/Pictures/active-background.jpg

#Screensaver stuff
sudo cp ~/.dotfiles/config/systemd/user/suspend@.service /etc/systemd/system/
sudo systemctl enable suspend@"$USER".service

#Change shell to fish
chsh -s /usr/bin/fish
