/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew update

read -p "Are you on an M1 mac? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	arch -arm64 brew install fzf
	arch -arm64 brew install tmux
	arch -arm64 brew install autojump
else
	brew install fzf
	brew install tmux
	brew install autojump
fi
brew install neovim

$(brew --prefix)/opt/fzf/install

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tinty

cp ./.personalrc/examples/nnnrc ~/.personalrc
cp ./.personalrc/examples/fzfrc-base16 ~/.personalrc
