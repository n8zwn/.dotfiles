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
	while read PACKAGE
	do
        	trizen -S "$PACKAGE" --noconfirm
	done<pkgs
fi	


#Usual Desktop folders
mkdir -p ~/Documents ~/Downloads ~/Pictures ~/Desktop ~/git ~/Games ~/Iso

#Wallpaper
cp ~/.dotfiles/wallpapers/active-background.jpg ~/Pictures/active-background.jpg

#Screensaver stuff
sudo cp ~/.dotfiles/systemd/user/suspend@.service /etc/systemd/system/
sudo systemctl enable suspend@"$USER".service

#Enable lightdm
sudo systemctl enable lightdm.service

#Change shell to fish
clear
chsh -s /usr/bin/fish
if [[ -f arch-fish-config.txt ]]
then
	cp arch-fish-config.txt ~/.config/fish/config.fish
fi

clear
echo 'Install open-vm-tools? (y/n)'
read RESPONSE
case "$RESPONSE" in
    [yY] | [yY][eE][sS]) sudo pacman -S open-vm-tools --noconfirm && sudo systemctl enable vmtoolsd.service && sudo systemctl start vmtoolsd.service;;
esac
