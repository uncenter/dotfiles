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
up(){                                 # Go up X directories (default 1)
  if [[ "$#" -ne 1 ]]; then
    cd ..
  elif ! [[ $1 =~ '^[0-9]+$' ]]; then
    echo "error: argument should be a number (default=1)"
  else
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
      do
        d=$d/..
      done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
}

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

# Zellij auto-tab-rename (https://www.reddit.com/r/zellij/comments/10skez0/comment/jrimomm/).
zellij_tab_name_update() {
  if [[ -n $ZELLIJ ]]; then
    tab_name=''
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        tab_name+=$(basename "$(git rev-parse --show-toplevel)")/
        tab_name+=$(git rev-parse --show-prefix)
        tab_name=${tab_name%/}
    else
        tab_name=$PWD
            if [[ $tab_name == $HOME ]]; then
         	tab_name="~"
             else
         	tab_name=${tab_name##*/}
             fi
    fi
    command nohup zellij action rename-tab $tab_name >/dev/null 2>&1
  fi
}
zellij_tab_name_update
chpwd_functions+=(zellij_tab_name_update)

eval "$(starship init zsh)"
eval "$(fnm env)"
eval "$(atuin init zsh)"
eval "$(zellij setup --generate-auto-start zsh)"

integrations=(
    "$HOME/.config/broot/launcher/bash/br"
    "$HOME/.iterm2_shell_integration.zsh"
    "$HOME/.config/tabtab/zsh/__tabtab.zsh"
)
for file in "${integrations[@]}"; do
    [ -f "$file" ] && source "$file"
done
