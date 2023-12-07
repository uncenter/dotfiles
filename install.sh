#!/usr/bin/env sh

SOURCE="https://github.com/uncenter/dotfiles"
DOTFILES="$HOME/.dotfiles"

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
brew install stow

if ! have "git"; then
    brew install git
fi

mkdir -p "$DOTFILES"
git clone $SOURCE $DOTFILES

echo "Stowing dotfiles..."
for dir in */$DOTFILES; do
    echo "Stowing $DOTFILES/$dir to $HOME/$dir..."
    stow --target="$HOME" "$DOTFILES/$dir"
done

for f in ~/.bin/*; do chmod +x $f; done

echo "Installing Homebrew packages..."
brew bundle install --file=Brewfile
brew cleanup --prune=all
echo "Installing and aliasing Node.js versions..."
cat 'Fnmfile' | while read -r line; do
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
echo "Installing global npm packages..."
cat 'Pnpmfile' | while read -r line; do
    pnpm install --global $line
done
echo "Installing global Python packages..."
pip3 install --user -r requirements.txt
echo "Installing global Cargo packages..."
while IFS= read -r line; do
    name=$(echo "$line" | awk '{print $1}')
    version=$(echo "$line" | awk '{print $2}')
    url=$(echo "$line" | awk '{print $3}')

    IFS='#' read -ra parts <<< "${url:1:-1}"
    href=${parts[0]}
    hash=${parts[1]}

    if [[ $url != "" ]]; then
        cargo install --git "$href" --rev "$hash"
    else
        cargo install "$name" --version "${version:1}"
    fi
done < Cargofile

