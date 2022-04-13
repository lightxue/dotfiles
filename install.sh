#!/bin/bash

PWD=`pwd`

sudo apt-get update
# install zsh
sudo apt-get install -y zsh

# install oh-my-zsh
sudo apt-get install -y curl

REMOTE='https://github.com/ohmyzsh/ohmyzsh.git' sh -c "$(curl -fsSL https://raw.staticdn.net/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zplug
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

sudo apt-get install -y python3 python3-pip

mv ~/.zshrc ~/.zshrc.bak
ln -s $PWD/zsh/zshrc ~/.zshrc
test -e ~/.zsh && rm -rf ~/.zsh.bak && mv ~/.zsh ~/.zsh.bak
ln -s $PWD/zsh/zsh ~/.zsh

# install tmux
sudo apt-get install -y tmux
ln -s $PWD/tmux/tmux.conf ~/.tmux.conf

# install vim
test -e ~/.vim && rm -rf ~/.vim.bak && mv ~/.vim ~/.vim.bak
ln -s $PWD/vim/vim/ ~/.vim
ln -s $PWD/vim/vimrc ~/.vimrc
mkdir ~/.vim/bundle
git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/vim-plug --depth=1

# install git
ln -s $PWD/git/gitconfig ~/.gitconfig

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf --depth=1
~/.fzf/install

# handy tools
sudo apt-get install -y htop glances ack-grep ctags cscope finger tree cloc aria2 silversearcher-ag nnn ripgrep axel cowsay axel
# brew install htop glances ctags cscope tree cloc aria2 nnn ripgrep axel cowsay axel
sudo pip3 install ipython jupyter tldr mycli httpie

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts
npm install -g diff-so-fancy
npm install -g bash-language-server
