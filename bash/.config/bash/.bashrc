#!/usr/bin/env bash

if command -v brew &>/dev/null
then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
    then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
        do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
fi

[ -f "${XDG_CONFIG_HOME}/sh/aliases" ] && source "${XDG_CONFIG_HOME}/sh/aliases"

BASH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash"
[[ -d "$BASH_DATA_DIR" ]] || mkdir -p "$BASH_DATA_DIR"
export HISTFILE="$BASH_DATA_DIR/history"

shopt -s histappend
shopt -s histverify

eval "$(starship init bash)"
eval "$(fnm env)"
eval "$(atuin init bash)"
