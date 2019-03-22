function ubuntu
    set working_dir (pwd)
    set ubuntu_dir ~/.vagrant/ubuntu
    mkdir -p $ubuntu_dir
    cd $ubuntu_dir
    if test ! -f $ubuntu_dir/Vagrantfile
        vagrant init ubuntu/bionic64
        rm $ubuntu_dir/Vagrantfile
        curl 'https://gist.githubusercontent.com/heywoodlh/ab3706570b1ad6da233053e27527060d/raw/354f2b8c151b01ad298171f7ca75aa99911e7b44/ubuntu-vagrantfile' -o $ubuntu_dir/Vagrantfile
    end
    vagrant up
    vagrant ssh
    cd $working_dir
end
