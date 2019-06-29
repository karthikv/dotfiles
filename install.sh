cd ~
echo "Cloning dotfiles repository..."
git clone git@github.com:karthikv/dotfiles.git

echo "Symlinking dotfiles..."
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/vim .vim

cd ~
echo "Done!"
