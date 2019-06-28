function weechat
  docker run -it --name weechat -e UID=1000 -e GID=1000 -v ~/.weechat:/weechat jkaberg/weechat $argv
end
