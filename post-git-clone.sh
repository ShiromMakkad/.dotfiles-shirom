cd ~
cp -a .dotfiles-shirom/. ~
sudo chmod +x setup.sh
./setup.sh
git clone https://github.com/edkolev/tmuxline.vim.git ~/.vim/bundle/tmuxline.vim && rm -r ~/.vim/bundle/tmuxline.vim/.git
rm "Install instructions.txt"
rm "p10k config.txt"
rm setup.sh
rm "Inconsolata Nerd Font Complete Windows Compatible.otf"
rm -r .git
rm -r .dotfiles-shirom
rm -r "Windows Terminal"
rm post-git-clone.sh
