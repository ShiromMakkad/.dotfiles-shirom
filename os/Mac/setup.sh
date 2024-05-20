/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew update

brew install fzf
brew install tmux
brew install autojump
brew install neovim
brew install helix

$(brew --prefix)/opt/fzf/install

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tinty

cp ./.personalrc/examples/nnnrc ~/.personalrc
cp ./.personalrc/examples/fzfrc-base16 ~/.personalrc
