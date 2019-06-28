function weechat
  if docker ps | grep -q weechat
    docker exec -it weechat weechat 
  else
    if docker ps -a | grep -q weechat
      docker start weechat > /dev/null
      docker exec -it weechat weechat
    else
      if test -z ~/.weechat-docker
        mkdir -p ~/.weechat-docker
      end
      docker run -it --name weechat -e UID=1000 -e GID=1000 -v ~/.weechat-docker:/weechat jkaberg/weechat $argv
    end
  end
end
