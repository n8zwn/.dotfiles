function prepend_sudo -d "Toggle sudo prefix"
  if test -z (commandline)
    commandline -r $history[1]
  end
  commandline | read -la cmd_buffer
  if not contains "sudo" $cmd_buffer
    commandline -r "sudo $cmd_buffer"
  else
    commandline -r (echo "$cmd_buffer" | sed -E s/"^sudo\s+(.*)"/"\1"/)
  end
end
