#!/usr/bin/env bash

# Update Cached sudo credentials
echo "Updating cached sudo credentials"
sudo -v

#Core dependencies
#sudo pacman -S xss-lock alacritty i3-gaps feh

#AUR dependencies
#pacaur -S albert fundle-git fish ttf-dejavu vim firefox xorg-server xorg-xinit python-pip compton xterm network-manager-applet polybar pulseaudio keychain gnome-keyring i3lock-fancy-git 


echo "Updating cache"
sudo apt-get update
echo "Installing from pkgs file"
while read PACKAGE
do
	sudo apt-get install "$PACKAGE" -y
done<pkgs


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

#Install kitty
#curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
#sudo cp ~/.local/kitty.app/share/applications/kitty.desktop /usr/local/share/applications

#Install virtualfish
sudo pip3 install virtualfish

#Configure bw cli
clear
echo 'Bitwarden server URL: '
read BW_SERVER
/snap/bin/bw config server "$BW_SERVER"

/snap/bin/bw login --raw >> ~/.bw_session
(crontab -l ; echo "*/30 * * * * rm ~/.bw_session")| crontab -

#Install docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker "$USER"
