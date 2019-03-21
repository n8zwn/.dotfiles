function macos-poweroff
    set working_dir (pwd)
    set macos_dir ~/.vagrant/macos
    cd $macos_dir
    vagrant suspend
    cd $working_dir
end
