function windows
    set working_dir (pwd)
    set windows_dir ~/.vagrant/windows
    mkdir -p $windows_dir
    cd $windows_dir
    if test ! -f $windows_dir/Vagrantfile
        vagrant init Microsoft/EdgeOnWindows10 --box-version 1.0
        rm $windows_dir/Vagrantfile
        curl 'https://gist.githubusercontent.com/heywoodlh/96682f1694dac4f47271febd7592a8e7/raw/c6459551d042738a1da2182cbf1f6a58a3f4d08d/windows-vagrant' -o $windows_dir/Vagrantfile
    end
    vagrant up
    vagrant powershell
    vagrant suspend
    cd $working_dir
end
