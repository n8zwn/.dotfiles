#!/bin/bash

dir=~/.dotfiles
olddir=~/.dotfiles_old

# List of files/folders to symlink in homedir
files="bashrc bash_profile vim dircolors gitconfig Xresources config xinitrc tmux.conf dircolors bw-scripts do-scripts chunkwm_plugins chunkwmrc"

# Create .dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles..."
mkdir -p $olddir
echo "done"

# Change to the dotfiles directory
cd $dir

# Move any existing dotfiles to dotfiles_old directory, and create symlinks
# from the homedir to any files in the ~/dotfiles
for file in $files; do
    mv ~/.$file ~/.dotfiles_old/
    ln -s $dir/$file ~/.$file
done
