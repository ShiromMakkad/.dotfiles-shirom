#!/bin/bash

cd "$(dirname "$0")"

install=0
wsl=0
os=""

parse_flags() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --os)      os=$(echo "$2" | tr '[:upper:]' '[:lower:]') || exit 1; shift 2 ;;
            --install) install=1; shift ;;
            --wsl)     wsl=1; shift ;;
            -h|--help)
                echo "Usage: installer.sh --os ubuntu|fedora|mac [--install] [--wsl]"
                echo "  --os <os>    Target OS (ubuntu, fedora, mac)"
                echo "  --install    Install programs (not just dotfiles)"
                echo "  --wsl        WSL installation"
                exit 0
                ;;
            *)  echo "Unknown option: $1"; exit 1 ;;
        esac
    done

    if [[ -z "$os" ]]; then
        echo "Error: --os is required."
        exit 1
    fi
}

validate_inputs() {
    if [[ "$EUID" -eq 0 ]]; then
        echo "Do not run with sudo!"
        exit 1
    fi

    case $os in
        ubuntu|fedora|mac) ;;
        *) echo "Error: Invalid OS '$os'. Use ubuntu, fedora, or mac."; exit 1 ;;
    esac

    if [[ "$os" == "mac" && "$(uname -m)" != "arm64" ]]; then
        echo "Installer is only supported for M-series Macs."
        exit 1
    fi
}

parse_flags "$@"
validate_inputs

# Execution ----
install_helix() {
    mkdir -p ~/Downloads
    if [ -d ~/Downloads/helix ]; then
        git -C ~/Downloads/helix pull
    else
        git clone https://github.com/helix-editor/helix ~/Downloads/helix
    fi
    cargo install \
        --profile opt \
        --config 'build.rustflags="-C target-cpu=native"' \
        --path ~/Downloads/helix/helix-term \
        --locked
    ln -sf ~/Downloads/helix/runtime ~/.config/helix/runtime
}

mkdir -p ~/.personalrc

os_dir="$(echo "$os" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
exec_dir="./os/${os_dir}"
find "$exec_dir" -maxdepth 1 -name "*rc" -exec cp {} ~/.personalrc \;
if [[ $install -eq 1 && -f "$exec_dir/setup.sh" ]]; then
    bash -c "$exec_dir/setup.sh"
fi

cp -rn .personalrc ~

echo "Copying dotfiles..."
cp -a dotfiles/. ~

echo "Installing Vim plugins..."
vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall

if [[ $wsl -eq 1 ]]; then
    exec_dir=./os/WSL
    find "$exec_dir" -maxdepth 1 -name "*rc" -exec cp {} ~/.personalrc \;
    if [[ -f "$exec_dir/setup.sh" ]]; then
        bash -c "$exec_dir/setup.sh"
    fi
fi

# Generic installation
if [[ $install -eq 1 ]]; then
    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all

    # Install Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    PATH=$PATH:~/.cargo/bin
    cargo install cargo-binstall --locked
    cargo binstall -y tinty
    cargo binstall -y zoxide --locked
    cargo binstall -y lsd
    cargo binstall -y ripgrep
    cargo binstall -y fd-find
    cargo binstall -y --locked yazi-fm yazi-cli
    cargo binstall -y zellij --locked
    cargo binstall -y git-delta

    install_helix
fi

echo "Applying Tinty"
tinty install
tinty apply base16-tomorrow-night-eighties

echo "Done! Run this script again to update. "
