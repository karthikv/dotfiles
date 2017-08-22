cd ~
echo "Cloning dotfiles repository..."
git clone --recursive https://github.com/taithethai/dotfiles.git

echo "Symlinking dotfiles..."
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/zshrc .zshrc
ln -s ~/dotfiles/vim .vim
ln -s ~/dotfiles/oh-my-zsh .oh-my-zsh

cd ~
echo "Done!"
