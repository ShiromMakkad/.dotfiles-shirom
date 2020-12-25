#!/bin/bash

dir_exec() {
    cd "$(dirname "$0")"
    # Copy over every rc file to .personalrc
    find "$os_dir" -maxdepth 1 -name "*rc" -exec cp {} ~/.personalrc \;
    # Run every setup.sh
    if [[ install -eq 1 ]]; then 
        find $os_dir -maxdepth 1 -name 'setup.sh' -exec {} \;
    fi
}

tools() {
    if [[ $tools -eq 1 ]]
    then
        os_dir="${os_dir}/default-tools"
        dir_exec
    fi
}

tools_prompt() {
    if [[ install -eq 1 ]]; then 
        read -p "Would you like to install tools? (ex. NVM, Anaconda, etc.) (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            tools=1
        fi
    fi
}

linux() {
    os_dir=./os/Linux
    dir_exec 
}

ubuntu() {
    tools_prompt

    linux

    os_dir=./os/Ubuntu
    dir_exec

    tools
}

raspbian() {
    linux
    os_dir=./os/Raspbian
    dir_exec
}

wsl() {
    os_dir=./os/WSL
    dir_exec
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

mkdir ~/.personalrc

PS3='Which OS are you installing on? '
options=("Ubuntu" "Raspbian" )
select opt in "${options[@]}"
do
    case $opt in
        "Ubuntu")
            installer_prompt
            wsl_prompt
            ubuntu
            if [[ wsl -eq 1 ]]; then
                wsl
            fi
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

cd "$(dirname "$0")"

echo "Installing plugins..."
git submodule update --init --recursive --remote
echo "Plugins installed!"

cp -a dotfiles/. /home/shirom
cp -rn .personalrc ~

~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "Done! Run this script again to update. "
