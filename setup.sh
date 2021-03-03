#!/bin/bash

# Install vim-plug from github
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Next, open vim and run PlugInstall.

# Dont forget to install ripgrep
# brew install ripgrep
# sudo apt install ripgrep (Ubuntu 18.07+)

