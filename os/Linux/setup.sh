# Install fzf
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tinty

cp ./.personalrc/examples/nnnrc ~/.personalrc
cp ./.personalrc/examples/fzfrc-base16 ~/.personalrc
