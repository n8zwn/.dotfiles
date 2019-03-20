function kali-poweroff
    set working_dir (pwd)
    set kali_dir ~/.vagrant/kali
    cd $kali_dir
    vagrant suspend
    cd $working_dir
end
