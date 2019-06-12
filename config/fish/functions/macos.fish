function macos
    set working_dir (pwd)
    set macos_dir ~/.vagrant/macos
    mkdir -p $macos_dir
    cd $macos_dir
    if test ! -f $macos_dir/Vagrantfile
        vagrant init yzgyyang/macOS-10.14
    end
    vagrant up
    vagrant ssh
    cd $working_dir
end
