#!/usr/bin/env bash

PWD="$(PWD)"
cd ~/
NEW_PATH='~/bin/'
mkdir -p "$NEW_PATH"
echo PATH="$PATH":"$NEW_PATH":~/.local/bin >> ~/.profile


BW_CLI='https://vault.bitwarden.com/download/?app=cli&platform=linux'
JQ='https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'


wget "$BW_CLI" -O ~/bin/master.zip
unzip ~/bin/master.zip -d ~/bin
chmod +x ~/bin/bw
rm ~/bin/master.zip

wget "$JQ" -O ~/bin/jq
chmod +x ~/bin/jq

# https://www.dangtrinh.com/2014/02/xfce-410-add-shortcut-keys-by-command.html
xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/Super_L" --create --type string --set "xfce4-popup-applicationsmenu"

SHORTCUT_FILE='./xfce4-keyboard-shortcuts.xml'
SHORTCUT_FILE_DEST='~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml'

cp "$SHORTCUT_FILE" "$SHORTCUT_FILE_DEST"


echo "CommandLoginShell=TRUE" >> ~/.config/xfce4/terminal/terminalrc


echo 'if [[ -f ~/.bw_session ]]' >> ~/.profile
echo 'then' >> ~/.profile
echo '    BW_SESSION="$(cat ~/.bw_session)"' >> ~/.profile
echo 'fi' >> ~/.profile



cd "$PWD"
