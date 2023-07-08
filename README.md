<div align="center">

<h1>Dotfiles</h1>

![macOS](https://img.shields.io/badge/macOS-13.5-47999e.svg?style=flat-square)
[![GNU Stow](https://img.shields.io/badge/GNU%20Stow-2.3.1-b48ead.svg?style=flat-square)](https://www.gnu.org/software/stow/)

My dotfiles configuration for macOS!

</div>

> This repository was heavily inspired by [rememberYou/dotfiles](https://github.com/rememberYou/dotfiles) and [ryanccn/dotfiles](https://github.com/ryanccn/dotfiles), many thanks to them!

## Structure

I like to keep my home directory as clean as possible in accordance with the [XDG base directory specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

| Variable          | Location         |
| ----------------- | ---------------- |
| `XDG_CONFIG_HOME` | `~/.config`      |
| `XDG_CACHE_HOME`  | `~/.cache`       |
| `XDG_STATE_HOME`  | `~/.local/state` |
| `XDG_DATA_HOME`   | `~/.local/share` |
| `XDG_BIN_HOME`    | `~/.local/bin`   |

## Dotfiles manager

I'm using [GNU Stow](https://www.gnu.org/software/stow/) - a free, lightweight
dotfiles manager written in Perl. I really don't know why I went with it other than it is simple and basic. I have tried a few others, such as [chezmoi](https://www.chezmoi.io/), but they were overcomplicated or just annoying to use.

## Getting started

```sh
brew install stow
```

Once the installation is complete, make a clone of the repository:

```sh
git clone https://github.com/uncenter/dotfiles.git .dotfiles
```

You can now install any configurations you wish to copy using GNU Stow.

## Caveats

### `zsh` and `bash`

For the configuration of `zsh` and `bash`, you will need to create two
symbolic aliases:

```bash
ln -s ~/.config/bash/.bashrc ~
ln -s ~/.config/zsh/zshenv .zshenv
```

Only `.zshenv` is required for `zsh` to work properly as it is the first file in a chain of files (`.zshenv` -> `sh/profile` -> `sh/env` -> `zsh/xdg` -> sets `$ZDOTDIR` -> `.zshrc`). I don't use `bash` but I keep it around just in case.

### Partial linking

Additionally, some directories should be only "partially linked". For example, the `antidote` plugin manager for `zsh` will autogenerate a `.zsh_plugins.zsh` file in `$ZDOTDIR`. This file should not be linked and to avoid this, we can link the contents of the directory instead of the directory itself by creating the directory and then linking the contents:

```bash
mkdir -p ~/.config/zsh/
stow zsh
```

`newsboat` should also be partially linked as it will generate a `cache.db` file in its directory.

### Dumb CLIs

`silicon` needs themes and to do so we need to create a symlink to the themes directory (after stowing all the configs, or at least just `bat`):

```bash
ln -s ~/.config/bat/themes/ ~/.config/themes
silicon --build-cache
```

**Note:** Silicon may also error if there isn't a `~/.config/syntaxes` directory. This can be fixed by creating the directory and then running `silicon --build-cache` again.

## License

Unlicensed, take what you like.
