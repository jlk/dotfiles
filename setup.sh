#!/bin/sh

BACKUP_TIMESTAMP=`date "+%Y%m%d"`

# Pick up submodule(s)
git submodule init
git submodule update

# This is fairly quick and dirty - if files we're going to install exist, just move them out of the way as a "backup"
echo "Backing up files, if necessary"
if [ -d ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc-$BACKUP_TIMESTAMP
fi
if [ -d ~/.bash_login ]; then
    mv ~/.bash_login ~/.bash_login-$BACKUP_TIMESTAMP
fi
if [ -d ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc-$BACKUP_TIMESTAMP
fi
if [ -d ~/.vim ]; then
    mv ~/.vim ~/.vim-$BACKUP_TIMESTAMP
fi
if [ -d ~/.gitignore ]; then
    mv ~/.gitignore ~/.gitignore-$BACKUP_TIMESTAMP
fi

# If zsh is around, install ohmyzsh, powerline.
echo "If zsh not found error is displayed, ignore."
set +e
zsh --version > /dev/null
if [ $? -eq 0 ]; then
    if [ -d ~/.oh-my-zsh ]; then
        mv ~/.oh-my-zsh ~/.oh-my-zsh-$BACKUP_TIMESTAMP
    fi
    RUNSH=no sh -c zsh/ohmyzsh-install.sh --unattended
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    cp zsh/zshrc ~/.zshrc
    cp zsh/p10k.zsh ~/.p10k.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    cp zsh/oh-my-zsh.sh ~/.oh-my-zsh
fi
set -e

echo "Setting up dotfiles"
cp bash/bashrc ~/.bashrc
cp bash/bash_login ~/.bash_login
cp .gitignore ~/.gitignore
if [ ! -d ~/.vim ]; then
    mkdir ~/.vim
fi
cp vim/vimrc ~/.vimrc
cp -Rp vim/autoload vim/bundle ~/.vim
