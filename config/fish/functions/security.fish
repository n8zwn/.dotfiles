function sniper
    docker run --rm -ti menzo/sn1per-docker sniper $argv
end

function blackwidow
    docker run -it blackwidow $argv
end

function geoiplookup
    curl ipinfo.io/"$argv"
end

function whatismyip
   curl 'https://api.ipify.org?format=text'
end

function vulnscan
   nmap -sV --script=vulscan/vulscan.nse $argv
end
