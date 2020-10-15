#!/usr/bin/env bash

# Initial dotfile and soft-link setup

DOTFILES=(".vimrc" ".tmux.conf" ".zshrc")

VUNDLE_REPO="https://github.com/VundleVim/Vundle.vim.git"
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"

check_exists () {
    if [[ -e "$1" ]]; then
        echo "$1 already exists. Are you sure you need to init?"
        exit 1
    fi
}

install_vundle () {
    if [[ -e "$VUNDLE_DIR" ]]; then
        echo "Error: Vundle already exists."
        exit 1
    fi

    git clone "$VUNDLE_REPO" "$VUNDLE_DIR" &&\
        echo "Successfully installed Vundle"
}

setup () {
    pushd "$HOME"
    source_dir=$(dirname "${BASH_SOURCE[0]}")
    
    #install_vundle || true
    for file in "${DOTFILES[@]}"
    do
        check_exists "$HOME/$file" &&\
            ln -s "$source_dir"/"$file" "$HOME/$file" &&\
            echo "Successfully set up $file"
    done
    popd
}


setup
