function bitwarden-sync
   set BW_SESSION (cat ~/.bw_session)
   bw sync --session "$BW_SESSION"
end
