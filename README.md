<h1>Dotfiles</h1>

![macOS](https://img.shields.io/badge/macOS-14.0-47999e.svg?style=flat-square)
[![GNU Stow](https://img.shields.io/homebrew/v/stow?style=flat-square&label=GNU%20Stow&color=b48ead)](https://formulae.brew.sh/formula/stow)

My dotfiles configuration for macOS!

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

I'm using [GNU Stow](https://www.gnu.org/software/stow/) ([documentation](https://www.gnu.org/software/stow/manual/stow.html)) - a free and lightweight
dotfiles manager written in Perl. I have tried a few dotfile managers such as [chezmoi](https://www.chezmoi.io/), but all were overcomplicated and just annoying to use. I used this [incredibly helpful guide](https://www.jakewiesler.com/blog/managing-dotfiles) to get started with `stow` and it has been working great so far!

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

## Caveats

### `bash`

To configure `bash`, you will need to create a
symbolic alias:

```bash
ln -s ~/.config/bash/.bashrc ~
```

## Other packages

Some applications I use are not available on Homebrew, so I install them manually:

-   [uncenter/wifi-password](https://github.com/uncenter/wifi-password) - a simple script to get the password of the WiFi you're currently connected to.
-   [uncenter/fn](https://github.com/uncenter/fn) - a CLI wrapper to simplify managing Newsboat.

## License

Creative Commons Zero v1.0 Universal
