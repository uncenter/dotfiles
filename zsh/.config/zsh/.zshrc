# Homebrew completions:
if command -v brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

# Case-insensitive (uppercase from lowercase) completion:
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Case-insensitive (all) completion:
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':zsh-utils:plugins:completion' use-xdg-basedirs 'yes'

# https://zsh.sourceforge.io/Doc/Release/Options.html
setopt auto_cd
setopt always_to_end
unsetopt menu_complete
setopt auto_menu
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_verify

ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
[[ -d "$ZSH_DATA_DIR" ]] || mkdir -p "$ZSH_DATA_DIR"
export HISTFILE="$ZSH_DATA_DIR/history"
export HISTSIZE=10000 # Maximum number of events to save in the internal history.
export SAVEHIST=10000 # Maximum number of events to save in the history file.

# https://github.com/ryanccn/vivid-zsh
vivid_theme="catppuccin-macchiato"

# Prevent text from being highlighted when pasted into the terminal:
zle_highlight=('paste:none')

# Antidote
zstyle ':antidote:bundle' use-friendly-names 'yes'
export ANTIDOTE_HOME="${HOME}/.cache/antidote"
source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load "${ZDOTDIR:-$HOME}/.zsh_plugins.txt"

# Aliases
[ -f "${XDG_CONFIG_HOME}/sh/aliases" ] && source "${XDG_CONFIG_HOME}/sh/aliases"

# Newline fix.
precmd() {
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo
    fi
}
alias clear="unset NEW_LINE_BEFORE_PROMPT && clear"
alias reset="unset NEW_LINE_BEFORE_PROMPT && reset"

eval "$(starship init zsh)"
eval "$(fnm env)"
eval "$(atuin init zsh)"

[ -f "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"
[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ] && source "$HOME/.config/tabtab/zsh/__tabtab.zsh"