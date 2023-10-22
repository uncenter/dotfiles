# ~/.config/fish/config.fish - Fish shell configuration.

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -gx XDG_TRASH_HOME "$HOME/.Trash"
# Custom XDG directories.
set -gx XDG_DEV_DIR "$HOME/Dev"
set -gx XDG_SCRIPT_DIR "$HOME/.bin"

# Environment variables for specific programs.
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -gx SHELL_SESSIONS_DISABLE 1
set -gx GIT_CONFIG_GLOBAL "$XDG_CONFIG_HOME/git/config"
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc.py"
set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/nodejs/history"
set -gx PNPM_HOME "$XDG_CACHE_HOME/pnpm"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx GEM_HOME "$XDG_DATA_HOME/gem"
set -gx GHCUP_USE_XDG_DIRS 1
set -gx YARN_CACHE_FOLDER "$XDG_CACHE_HOME/yarn"
set -gx YARN_ENABLE_TELEMETRY 0
set -gx GNUPGHOME "$XDG_CONFIG_HOME/gnupg"
set -gx TEALDEER_CONFIG_DIR "$XDG_CONFIG_HOME/tealdeer"
set -gx TEALDEER_CACHE_DIR "$XDG_CACHE_HOME/tealdeer"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx STACK_XDG 1
set -gx WAKATIME_HOME "$XDG_CONFIG_HOME/wakatime"

set -gx GPG_TTY (tty)
# gpgconf --launch gpg-agent

set -gx LANG en_US.UTF-8
set -gx EDITOR "hx"
set -gx VISUAL "code"
set -gx LESS "-R"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

/opt/homebrew/bin/brew shellenv | source
pyenv init - | source

set -gx PATH $PYENV_ROOT/bin (brew --prefix ccache)/libexec $GOPATH/bin $CARGO_HOME/bin $PNPM_HOME $XDG_BIN_HOME $XDG_SCRIPT_DIR /opt/homebrew/opt/openjdk/bin $PATH

function have
    command -v $argv > /dev/null
end

function take
    mkdir -p $argv; and cd $argv; or return 1
end

function cdf
    cd (osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
end

function whatthecommit
    curl --silent --fail https://whatthecommit.com/index.txt
end

function mk
    mkdir -p (dirname $argv); and touch $argv
end

alias cat='bat'
alias ls='eza -F --icons --no-permissions --no-user -I .git'
alias ll='ls -la'
alias lst='ls --tree'
alias lsd='ls --only-dirs'
alias fd='fd --hidden'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias dig='doggo'
alias gitui='gitui -t macchiato.ron'

# Git
abbr -a gp git push origin
abbr -a gpm git push origin main
abbr -a gl git pull origin
abbr -a glm git pull origin main
abbr -a gc git commit -m
abbr -a glog git log
abbr -a gnew git checkout -b
abbr -a gs git checkout
abbr -a ga git add

# Shortcuts
alias uppercase='tr "[:lower:]" "[:upper:]"'
alias lowercase='tr "[:upper:]" "[:lower:]"'
alias puil='pnpm up --interactive --latest'

# Other
function urldecode
    python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))" $argv
end

function urlencode
    python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))" $argv
end

function randletter
    python3 -c "import sys, string, random; print(''.join([random.choice(string.ascii_letters) for _ in range(int(sys.argv[1] if len(sys.argv) > 1 else 1))]))" $argv
end

function randnum
    python3 -c "import sys, string, random; print(''.join([random.choice(string.digits) for _ in range(int(sys.argv[1] if len(sys.argv) > 1 else 1))]))" $argv
end

function randchar
    python3 -c "import sys, string, random; print(''.join([random.choice(string.printable) for _ in range(int(sys.argv[1] if len(sys.argv) > 1 else 1))]))" $argv
end

function nocache
    npm cache clean --force; pnpm store prune; yarn cache clean
end

# OS X specific aliases
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true; and killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false; and killall Finder"
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

function update
  brew update
  brew upgrade
  brew cleanup --prune=all
  softwareupdate -i -a --verbose
end

function ya
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function newlinefix --on-event fish_prompt
  if test -z "$NEW_LINE_BEFORE_PROMPT"
    set -gx NEW_LINE_BEFORE_PROMPT 1
  else if test "$NEW_LINE_BEFORE_PROMPT" -eq 1
    echo
  end
end
function clear
  set -gx NEW_LINE_BEFORE_PROMPT
  command clear
end
function reset
  set -gx NEW_LINE_BEFORE_PROMPT
  command reset
end

starship init fish | source
fnm env | source
atuin init fish | source
source ~/.config/tabtab/fish/__tabtab.fish

