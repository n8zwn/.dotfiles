function openvas
    docker run -d -p 443:443 -p 9390:9390 --name openvas mikesplain/openvas
end
