#!/usr/bin/env bash


bw list items --search 'bw-onboarding-script' --session "$(cat ~/.bw_session)" | jq -r '.[].notes' > /tmp/bw-setup.sh
chmod +x /tmp/bw-setup.sh


/tmp/bw-setup.sh
