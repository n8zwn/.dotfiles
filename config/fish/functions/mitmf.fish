function mitmf
   if uname -a | grep -q linux
       set WORKING_DIR (pwd)
       mkdir -p ~/git/
       cd ~/git
       sudo apt-get install python-dev python-setuptools libpcap0.8-dev libnetfilter-queue-dev libssl-dev libjpeg-dev libxml2-dev libxslt1-dev libcapstone3 libcapstone-dev libffi-dev file -y
       if lsvirtualenv | grep -q MITMf
           workon MITMf
       else
           mkvirtualenv MITMf
       end
       git clone https://github.com/byt3bl33d3r/MITMf
       cd MITMf
       git submodule init
       git submodule update --recursive
       pip2 install -r requirements.txt
       python2 mitmf.py --help
   end
end
