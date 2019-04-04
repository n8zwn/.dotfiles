function bettercap
    docker run -it --privileged --net=host bettercap/bettercap $argv
end
