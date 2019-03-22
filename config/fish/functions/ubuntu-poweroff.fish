function ubuntu-poweroff
    set working_dir (pwd)
    set ubuntu_dir ~/.vagrant/ubuntu
    cd $ubuntu_dir
    vagrant suspend
    cd $working_dir
end
