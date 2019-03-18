function arch-linux
    set working_dir (pwd)
    set arch_dir ~/.vagrant/arch
    mkdir -p $arch_dir
    cd $arch_dir
    if test ! -f $arch_dir/Vagrantfile
        vagrant init archlinux/archlinux
        rm $arch_dir/Vagrantfile
        curl 'https://gist.githubusercontent.com/heywoodlh/e24dc94eee7d461c215faa944af13bd7/raw/fbbc716c7a2af89753be13ba4727397cc6f2e123/arch-vagrant' -o $arch_dir/Vagrantfile
    end
    vagrant up
    vagrant ssh
    vagrant suspend
    cd $working_dir
end
