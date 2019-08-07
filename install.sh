cd ~
echo "Cloning dotfiles repository..."
git clone git@github.com:karthikv/dotfiles.git

echo "Symlinking dotfiles..."
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/vim .vim
ln -s ~/dotfiles/bashrc .bashrc

echo "Done!"
