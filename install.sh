cd ~
echo "Cloning dotfiles repository..."
git clone --recursive https://github.com/karthikv/dotfiles.git

echo "Symlinking dotfiles..."
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/zshrc .zshrc
ln -s ~/dotfiles/vim .vim
ln -s ~/dotfiles/oh-my-zsh .oh-my-zsh

echo "Building command-t plugin..."
cd vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

echo "Done!"
