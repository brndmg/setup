#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.26
nvm use v0.10.26

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint tern 

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/brndmg/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

#install bash git prompt
if [ ! -d ~/.bash-git-prompt/ ]; then
    git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt
fi

if [ ! -f ~/.git-completion.bash ]; then
    wget -O .git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi 

#install rvm
\curl -sSL https://get.rvm.io | bash -s stable --ruby -- --ignore-dotfiles
