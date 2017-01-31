#!/bin/bash

set -e 

# # Install all of the stuff not on ec2 - probably need to sudo
#    yum install tmux
#    yum install ctags
#    yum group install "Development Tools" 
#    yum install numpy
#    pip install boto3
#    pip install arrow
#    pip install click
#    pip install numpy




cwd=$(pwd)

# vim setup
ln -s $cwd/vim/vimrc ~/.vimrc
ln -s $cwd/vim ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/undo
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
plugins=( "https://github.com/Raimondi/delimitMate.git"
          "https://github.com/scrooloose/nerdtree.git"
          "https://github.com/scrooloose/nerdcommenter.git"
          "https://github.com/scrooloose/nerdtree-git-plugin.git"
          "https://github.com/ervandew/supertab.git"
          "https://github.com/vim-syntastic/syntastic.git"
          "https://github.com/vim-scripts/Tagbar.git"
          "https://github.com/vim-scripts/taglist.vim"
          "https://github.com/tell-k/vim-autopep8.git"
          "https://github.com/nvie/vim-flake8.git"
          "https://github.com/tpope/vim-fugitive.git"
          "https://github.com/airblade/vim-gitgutter.git"
          "https://github.com/nathanaelkane/vim-indent-guides.git"
          # "https://github.com/ntpeters/vim-better-whitespace.git" - Need to try this one out
          "https://github.com/benmills/vimux.git"
          "https://github.com/bronson/vim-trailing-whitespace.git"
          "https://github.com/itchyny/lightline.vim.git"
          "https://github.com/altercation/vim-colors-solarized.git"
          )
for plugin in "${plugins[@]}"
do
    echo "Installing $plugin"
    folder=$(echo $plugin | awk -F/ '{print $NF}' | awk -F. '{print $1}')
    git clone $plugin ~/.vim/bundle/$folder
done

# symbolic links
symlinks=( 'flake8'
           'sqliterc'
           'dircolors'
           'tmux.conf'
           'theanorc'
           'inputrc'
           'bashrc'
           'bash_profile'
           'gitignore_global'
         )
for link in "${symlinks[@]}"
do
    if [ -e ~/.$link ]
    then
        echo "Copying .$link to save.$link"
        mv ~/.$link ~/save.$link
    fi
    echo "Creating symlink ~/.$link -> dotfiles/misc/$link"
    ln -s $cwd/misc/$link ~/.$link
done

# One-off fixes
ln -s ~/.dircolors ~/.dir_colors
ln -s $cwd/keras ~/.keras



