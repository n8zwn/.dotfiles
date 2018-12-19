###Looks like this:
#(username@hostname)-(0)-(10:39 AM Wed Dec 25)->
#(~)-(20 files, 528b)--> 
###


PS1="\n\[\e[30;1m\]\[\016\]\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
