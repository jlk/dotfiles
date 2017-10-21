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

echo "Setting up dotfiles"
cp bash/bashrc ~/.bashrc
cp bash/bash_login ~/.bash_login
mkdir ~/.vim
cp vim/vimrc ~/.vimrc
cp -Rp vim/autoload vim/bundle ~/.vim
