#!/usr/bin/env bash

if [ ! -f ~/.bw_session ]
then
	bw unlock --raw > ~/.bw_session
fi

SESSION="$(cat ~/.bw_session)"

if [ "$SESSION" == "You are not logged in." ]
then
	echo "You are not logged in to a Bitwarden instance."
	echo "BW Server URL: "
	read BW_SERVER
	bw config server "$BW_SERVER"
	bw login --raw >> ~/.bw_session
fi

bw sync --session "$SESSION"


bw list items --search 'bw-onboarding-script' --session "$(cat ~/.bw_session)" | jq -r '.[].notes' > /tmp/bw-setup.sh
chmod +x /tmp/bw-setup.sh


/tmp/bw-setup.sh

rm /tmp/bw-setup.sh
