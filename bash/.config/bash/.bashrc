#!/usr/bin/env bash

[ -f "${XDG_CONFIG_HOME}/sh/aliases" ] && source "${XDG_CONFIG_HOME}/sh/aliases"

BASH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash"
[[ -d "$BASH_DATA_DIR" ]] || mkdir -p "$BASH_DATA_DIR"
export HISTFILE="$BASH_DATA_DIR/history"

shopt -s autocd
shopt -s histappend
shopt -s histverify