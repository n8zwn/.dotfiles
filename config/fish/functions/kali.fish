function kali
    set working_dir (pwd)
    set kali_dir ~/.vagrant/kali
    mkdir -p $kali_dir
    cd $kali_dir
    if test -f $kali_dir/Vagrantfile
        if test (grep '#   vb.gui = true' $kali_dir/Vagrantfile)
            sed -i -e 's/#   vb.gui = true/   vb.gui = false/g' $kali_dir/Vagrantfile
            vagrant reload
        end
    else
        vagrant init offensive-security/kali-linux
        if test (grep '#   vb.gui = true' $kali_dir/Vagrantfile)
            sed -i -e 's/#   vb.gui = true/   vb.gui = false/g' $kali_dir/Vagrantfile
        end
    end
    vagrant up
    vagrant ssh
    vagrant suspend
    cd $working_dir
end
