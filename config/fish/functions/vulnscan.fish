function vulnscan
   nmap -sV --script=vulscan/vulscan.nse $argv
end
