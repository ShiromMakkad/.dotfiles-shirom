#!/bin/bash

cd "$(dirname "$0")"

os_exec() {
    # Copy over every rc file to .personalrc
    find "$exec_dir" -maxdepth 1 -name "*rc" -exec cp {} ~/.personalrc \;
    # Run setup.sh
    if [[ install -eq 1 && -f "$exec_dir/setup.sh" ]]; then 
        bash -c "$exec_dir/setup.sh"
    fi
}

install_nvm() {
    if [[ $nvm -eq 1 ]]
    then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
        cp .personalrc/examples/nvmrc ~/.personalrc
        zsh -c "source ~/.personalrc/nvmrc && nvm install node"
    fi
}

nvm_prompt() {
    read -p "Would you like to install NVM (Node version manager)? These dotfiles need Node installed, but you don't need to install NVM if node is already installed (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        nvm=1
    fi
}

linux() {
    nvm_prompt

    exec_dir=./os/Linux
    os_exec 
}

ubuntu() {
    linux

    exec_dir=./os/Ubuntu
    os_exec
}

raspbian() {
    linux

    exec_dir=./os/Raspbian
    os_exec
}

install_wsl() {
    if [[ wsl -eq 1 ]]; then
        exec_dir=./os/WSL
        os_exec
    fi
}

wsl_prompt() {
    read -p "Is this a WSL installation? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        wsl=1
    fi
}

installer_prompt() {
    read -p "Would you like to install programs? (rather than just copy the dotfiles and plugins) (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        install=1
    fi
}

if [[ "$EUID" -eq 0 ]]; then 
    echo "Do not run with sudo!"
    exit
fi

mkdir -p ~/.personalrc

PS3='Which OS are you installing on? '
options=("Ubuntu" "Raspbian" )
select opt in "${options[@]}"
do
    case $opt in
        "Ubuntu")
            installer_prompt
            wsl_prompt
            ubuntu
            break
            ;;
        "Raspbian")
            installer_prompt
            raspbian
            break
            ;;
        *) echo "$REPLY is an invalid option. Try again";;
    esac
done

cp -rn .personalrc ~

install_nvm
install_wsl

echo "Installing modules..."
git submodule update --init --recursive --remote

echo "Copying dotfiles..."
cp -a dotfiles/. ~ 

echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "Installing Vim plugins..."
vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall

echo "Done! Run this script again to update. "
