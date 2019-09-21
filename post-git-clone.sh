cd ~
cp -a .dotfiles-shirom/. ~
sudo chmod +x setup.sh
./setup.sh
rm "Install instructions.txt"
rm "p10k config.txt"
rm setup.sh
rm -r .dotfiles-shirom
rm post-git-clone.sh
