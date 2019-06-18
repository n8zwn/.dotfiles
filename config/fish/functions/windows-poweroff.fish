function windows-poweroff
    set working_dir (pwd)
    set windows_dir ~/.vagrant/windows
    cd $windows_dir
    vagrant suspend
    cd $working_dir
end
