This repo serves as a simple Unix environment setup. Tested on Linux and OS X.



#### Generic Installation:


Installation Prerequisites:

- Git installed.
- Python 3 version of Peru installed (`sudo pip3 install peru`).
- (Optional) Fish set as default shell after it has been installed (`chsh -s $(which fish)`).

1. `cd ~`
2. `git clone https://github.com/heywoodlh/.dotfiles`
3. `cd ~/.dotfiles`
4. `peru sync`
5. `./.makesym.sh`


#### Arch Installation:

1. `cd ~`
2. `git clone https://github.com/heywoodlh/.dotfiles`
3. `cd .dotfiles`
4. `./scripts/install-pacaur`
5. `./scripts/arch-deps.sh`
6. `sudo pip instal peru`
7. `peru sync`
8. `./.makesym.sh`
9. `cp xinitrc ~/.xinitrc`

After going through all these steps, log out and then log back in.
