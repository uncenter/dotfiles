<h1>Dotfiles</h1>

![macOS](https://img.shields.io/badge/macOS-14.1.2-47999e.svg?style=flat-square)
[![GNU Stow](https://img.shields.io/homebrew/v/stow?style=flat-square&label=GNU%20Stow&color=b48ead)](https://formulae.brew.sh/formula/stow)

My dotfiles for macOS! I'm using [GNU Stow](https://www.gnu.org/software/stow/) ([documentation](https://www.gnu.org/software/stow/manual/stow.html)), a free and lightweight
dotfiles manager written in Perl, to manage these. I used this [incredibly helpful guide](https://www.jakewiesler.com/blog/managing-dotfiles) to get started with `stow`, definitely read it if you are unfamiliar with the program.

## My setup

- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Shell: [Fish](https://github.com/fish-shell/fish-shell)
- Prompt: [Starship](https://starship.rs/)
- Editor: [Visual Studio Code](https://code.visualstudio.com/)

I also use a bunch of CLI tools that have configurations here, see https://uncenter.dev/uses/#shell.

## Usage

```sh
brew install stow
```

```sh
git clone https://github.com/uncenter/dotfiles.git .dotfiles
```

You can now install any configurations you wish with `stow`:

```sh
cd .dotfiles
stow --target=$HOME <package>
```

### Updating

I use a script, `update.sh`, to update the various lists of packages (`Brewfile`, `Cargofile`, `Fnmfile`, `Pnpmfile`). You can run it with `just update` (assuming you have [just](https://github.com/casey/just) installed).

### Restoring

I haven't actually had to fully restore a system since I've made these, but I have a work-in-progress and unteseted install script, `install.sh`. It installs all of the packages in all of the `__file`s, and uses `stow` to symlink all of the configurations in this repository.

## Other packages

Some applications I use are not available on Homebrew, so I install them manually:

- [uncenter/wifi-password](https://github.com/uncenter/wifi-password) - a simple script to get the password of the WiFi you're currently connected to.
- [uncenter/fn](https://github.com/uncenter/fn) - a CLI wrapper to simplify managing Newsboat.
- [ryanccn/choirpack](https://github.com/ryanccn/choirpack) - Corepack wrapper.

## License

[Creative Commons Zero v1.0 Universal](LICENSE)

> [!NOTE]
> This repository was inspired by [rememberYou/dotfiles](https://github.com/rememberYou/dotfiles) and [ryanccn/dotfiles](https://github.com/ryanccn/dotfiles), many thanks to them!
