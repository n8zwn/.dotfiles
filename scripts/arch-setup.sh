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

#Change shell to fish
clear
echo 'Set fish as default shell? (y/n)'
read RESPONSE
case "$RESPONSE" in
    [yY] | [yY][eE][sS]) chsh -s /usr/bin/fish && cat arch-fish-config.txt >> ~/.config/fish/config.fish ;;
    [nN] | [nN][oO]) cat arch-bash-config.txt >> ~/.bash_profile;; 
esac

clear
echo 'Install open-vm-tools? (y/n)'
read RESPONSE
case "$RESPONSE" in
    [yY]) sudo pacman -S open-vm-tools && sudo systemctl enable vmtoolsd.service && sudo systemctl start vmtoolsd.service;;
esac
