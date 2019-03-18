function kali
    set working_dir (pwd)
    set kali_dir ~/.vagrant/kali
    mkdir -p $kali_dir
    cd $kali_dir
    if test ! -f $kali_dir/Vagrantfile
        vagrant init offensive-security/kali-linux
        rm $kali_dir/Vagrantfile
        curl 'https://gist.githubusercontent.com/heywoodlh/ab3706570b1ad6da233053e27527060d/raw/3f394d22c79bb97420d193d1b27b14071633fd0b/kali-vagrantfile' -o $kali_dir/Vagrantfile
    end
    vagrant up
    vagrant ssh
    vagrant suspend
    cd $working_dir
end
