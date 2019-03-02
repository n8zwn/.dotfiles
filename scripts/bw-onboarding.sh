#!/usr/bin/env bash

if [ ! -f ~/.bw_session ]
then
	bw unlock --raw > ~/.bw_session
fi


bw sync --session "$(cat ~/.bw_session)"


bw list items --search 'bw-onboarding-script' --session "$(cat ~/.bw_session)" | jq -r '.[].notes' > /tmp/bw-setup.sh
chmod +x /tmp/bw-setup.sh


/tmp/bw-setup.sh
