function bitwarden-sync
   set BW_SESSION (cat ~/.bw_session)
   bw sync --session "$BW_SESSION"
end

function slab
   ~/.bw-scripts/slab.sh
end

function 2fa
   ~/.bw-scripts/2fa.sh
end

if test -f ~/.bw_session
    set BW_SESSION (cat ~/.bw_session)
else
    set BW_SESSION ''
end
