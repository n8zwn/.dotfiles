if status --is-login 
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

set TERMINAL termite $TERMINAL

fundle plugin 'tuvistavie/fish-ssh-agent'

set SSH_AUTH_SOCK "$XDG_RUNTIME_DIR"/ssh-agent.socket

if status --is-interactive
    keychain --quiet --agents ssh
end

begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end
