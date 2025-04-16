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

ubuntu() {
    exec_dir=./os/Ubuntu
    os_exec
}

fedora() {
    exec_dir=./os/Fedora
    os_exec
}

mac() {
    exec_dir=./os/Mac
    os_exec
}

install_wsl() {
    if [[ wsl -eq 1 ]]; then
        exec_dir=./os/WSL
        os_exec
    fi
}

wsl_prompt() {
    read -r -p "Is this a WSL installation? [y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        wsl=1
    fi
}

installer_prompt() {
    read -r -p "Would you like to install programs? (rather than just copy the dotfiles and plugins) [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
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
options=("Ubuntu" "Fedora" "Mac")
select opt in "${options[@]}"
do
    case $opt in
        "Ubuntu")
            installer_prompt
            wsl_prompt
            ubuntu
            break
            ;;
        "Fedora")
            installer_prompt
            wsl_prompt
            fedora 
            break
            ;;
        "Mac")
            echo "Note: Installer is only supported for M-series chips."
            installer_prompt
            mac 
            break
            ;;
        *) echo "$REPLY is an invalid option. Try again";;
    esac
done

cp -rn .personalrc ~

install_wsl

# Generic installation
if [[ install -eq 1 ]]; then 
    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Install Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    PATH=$PATH:~/.cargo/bin
    cargo install zoxide --locked
    cargo install lsd
    cargo install ripgrep
    cargo install fd-find
    cargo install --locked yazi-fm yazi-cli
    # Have to stay on old version due to https://github.com/helix-editor/helix/issues/6551
    cargo install zellij --version 0.40.1 --locked
    cargo install tinty
    cargo install git-delta
fi

echo "Installing modules..."
git submodule update --init --recursive --remote

echo "Copying dotfiles..."
cp -a dotfiles/. ~ 

echo "Installing Vim plugins..."
vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall

echo "Applying Tinty"
tinty install
tinty apply base16-tomorrow-night-eighties

echo "Done! Run this script again to update. "
