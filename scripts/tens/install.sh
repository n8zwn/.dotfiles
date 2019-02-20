#!/usr/bin/env bash

PWD="$(pwd)"
cd /home/guest/
NEW_PATH='/home/guest/bin/'
mkdir -p "$NEW_PATH"
echo PATH="$PATH":"$NEW_PATH":/home/guest/.local/bin >> /home/guest/.profile


BW_CLI='https://vault.bitwarden.com/download/?app=cli&platform=linux'
JQ='https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'


wget "$BW_CLI" -O /home/guest/bin/master.zip
unzip /home/guest/bin/master.zip -d /home/guest/bin
chmod +x /home/guest/bin/bw
rm /home/guest/bin/master.zip

wget "$JQ" -O /home/guest/bin/jq
chmod +x /home/guest/bin/jq

# https://www.dangtrinh.com/2014/02/xfce-410-add-shortcut-keys-by-command.html
xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/Super_L" --create --type string --set "xfce4-popup-applicationsmenu"

SHORTCUT_FILE='./xfce4-keyboard-shortcuts.xml'
SHORTCUT_FILE_DEST='/home/guest/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml'

cp "$SHORTCUT_FILE" "$SHORTCUT_FILE_DEST"


echo "CommandLoginShell=TRUE" >> /home/guest/.config/xfce4/terminal/terminalrc


echo 'if [[ -f /home/guest/.bw_session ]]' >> /home/guest/.profile
echo 'then' >> /home/guest/.profile
echo '    BW_SESSION="$(cat /home/guest/.bw_session)"' >> /home/guest/.profile
echo 'fi' >> /home/guest/.profile



cd "$PWD"
