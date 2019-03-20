function arch-linux-poweroff
    set working_dir (pwd)
    set arch_dir ~/.vagrant/arch
    cd $arch_dir
    vagrant suspend
    cd $working_dir
end
