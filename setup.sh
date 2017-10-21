#!/bin/sh

BACKUP_TIMESTAMP=`date "+%Y%m%d"`

# Pick up submodule(s)
git submodule init
git submodule update

# This is fairly quick and dirty - if files we're going to install exist, just move them out of the way as a "backup"
if [ -d ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc-$BACKUP_TIMESTAMP
fi
if [ -d ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc-$BACKUP_TIMESTAMP
fi
if [ -d ~/.vim ]; then
    mv ~/.vim ~/.vim-$BACKUP_TIMESTAMP
fi

cp bash/bashrc ~/.bashrc
mkdir ~/.vim
cp vim/vimrc ~/.vimrc
cp -Rp vim/autoload vim/bundle ~/.vim
