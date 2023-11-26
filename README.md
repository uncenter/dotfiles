<h1>Dotfiles</h1>

![macOS](https://img.shields.io/badge/macOS-14.1.1-47999e.svg?style=flat-square)
[![GNU Stow](https://img.shields.io/homebrew/v/stow?style=flat-square&label=GNU%20Stow&color=b48ead)](https://formulae.brew.sh/formula/stow)

My dotfiles configuration for macOS!

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
dotfiles manager written in Perl. I used this [incredibly helpful guide](https://www.jakewiesler.com/blog/managing-dotfiles) to get started with `stow`, definitely read it if you are unfamiliar with the program.
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

## Other packages

Some applications I use are not available on Homebrew, so I install them manually:

- [uncenter/wifi-password](https://github.com/uncenter/wifi-password) - a simple script to get the password of the WiFi you're currently connected to.
- [uncenter/fn](https://github.com/uncenter/fn) - a CLI wrapper to simplify managing Newsboat.
- [ryanccn/choirpack](https://github.com/ryanccn/choirpack) - Corepack wrapper.

## License

[Creative Commons Zero v1.0 Universal](LICENSE)

> [!NOTE]
> This repository was inspired by [rememberYou/dotfiles](https://github.com/rememberYou/dotfiles) and [ryanccn/dotfiles](https://github.com/ryanccn/dotfiles), many thanks to them!
