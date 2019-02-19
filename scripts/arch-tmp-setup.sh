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
	done<tmp-pkgs
fi	


#Enable sxhkd
sudo cp ~/.dotfiles/systemd/sxhkd.service /etc/systemd/system/
sudo systemctl enable sxhkd.service
sudo systemctl start sxhkd.service


#Enable snapd
sudo systemctl enable snapd.service
sudo systemctl start snapd.service

if command -v snap 
then
	sudo ln -s /var/lib/snapd /snap
	echo "Installing snaps from snap file"
	while read PACKAGE
	do
        	sudo snap install "$PACKAGE"
	done<snaps
fi	


#Change shell to fish
clear
chsh -s /usr/bin/fish
if [[ -f arch-fish-config.txt ]]
then
	cp arch-fish-config.txt ~/.config/fish/config.fish
	echo 'fish; exit $?' >> ~/.profile
fi


#Install virtualfish
sudo pip3 install virtualfish

#Configure bw cli

clear
echo 'Bitwarden server URL: '
read BW_SERVER
bw config server "$BW_SERVER"

bw login --raw >> ~/.bw_session
sudo systemctl enable cronie.service
sudo systemctl start cronie.service
(crontab -l ; echo "*/30 * * * * rm ~/.bw_session")| crontab -
