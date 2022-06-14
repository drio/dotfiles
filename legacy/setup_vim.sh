#!/bin/bash
set -e

function bye() {
  local msg=$1
  echo $1 >&2
  exit 1
}

cd
for f in dotfiles .vimrc .vim
do
  [ -f $f ] && bye "$f exists. Bailing out."
done

git clone https://github.com/drio/dotfiles

cp dotfiles/.vimrc .
cp -r dotfiles/vim ./.vim

mkdir .vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "You will get an error from the solarized package. That's ok."
vim +BundleInstall +qall
