#!/usr/bin/env sh
# 
# setup.sh - setup dotfiles on a new machine

if [ ! $(uname) = "Darwin" ]; then
    echo "This script is for macOS only."
    exit 1
fi

have() { command -v $1 &> /dev/null; }

if ! have brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew..."
    brew update
fi
brew upgrade
brew install gum stow
stowsym() {
    for dir in */; do
        if [ ! "$dir" = "$1" ]; then
            gum spin --title "Stowing $dir..." -- stow --verbose --target="$HOME" "$dir"
        fi
    done
}
gun spin --title "Stowing dotfiles..." -- stowsym
for f in ~/.bin/*; do chmod +x $f; done
gum spin --title "Installing Homebrew packages..." -- brew bundle install --file=Brewfile
brew cleanup --prune=all

fnmfile() {
    cat Fnmfile | while read -r line; do
        version=$(echo $line | awk '{print $1}')
        alias=$(echo $line | awk '{print $2}')
        if [ -z $alias ]; then
            alias=""
        fi
        if ! fnm list | grep -Eo $version &> /dev/null; then
            fnm install $version
        fi
        fnm alias $version $alias
    done
}
gum spin --title "Installing and aliasing Node.js versions..." -- fnmfile
npmfile() {
    find . -name "Npmfile-*" | while read -r file; doå
        version=$(echo $file | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
        fnm use $version
        cat $file | while read -r line; do
            npm install --global $line@latest
        done
    done
}
gum spin --title "Installing global npm packages..." -- npmfile
gum spin --title "Installing global Python packages..." -- pip3 install --user -r requirements.txt