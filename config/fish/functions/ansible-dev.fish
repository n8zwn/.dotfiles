function ansible-dev
    set working_dir (pwd)
    set ubuntu_dir ~/.vagrant/ansible-dev
    mkdir -p $ubuntu_dir
    cd $ubuntu_dir
    if test ! -f $ubuntu_dir/Vagrantfile
        vagrant init ubuntu/bionic64
        rm $ubuntu_dir/Vagrantfile
        curl 'https://gist.githubusercontent.com/heywoodlh/ac1bf93bade2176d95a3000ccab35b8b/raw/409c8bbf085a5684774529c6e1750a76e11ca4b1/ubuntu-ansible-vagrant' -o $ubuntu_dir/Vagrantfile
    end
    vagrant up
    cd $working_dir
end
