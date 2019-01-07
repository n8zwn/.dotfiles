set fish_greeting ''

eval (python3 -m virtualfish compat_aliases)

if test -f ~/.bw_session
    set BW_SESSION (cat ~/.bw_session)
else
    set BW_SESSION ''
end

umask 077
