#!/usr/bin/env bash
# 
# update.sh - update dotfiles

cmds=(brew fnm pnpm pip3 git gum sd)
for cmd in ${cmds[@]}; do
    if ! command -v $cmd &> /dev/null; then
        echo "Required command \`$cmd\` not found!"
        exit 1
    fi
done

success() { gum style --foreground=2 "✓ $1"; }
fail() { gum style --foreground=1 "✗ $1"; }
warn() { gum style --foreground=3 "* $1"; }
info() { gum style --foreground=4 "i $1"; }

spin() {
  local title="$1"
  shift
  gum spin --spinner.foreground="255" --title "$title" "$@"
}

spin "Updating Brewfile..." -- brew bundle dump --force && success "Updated Brewfile."
pnpm -g list | grep -Eo '@?[a-zA-Z0-9/-]+ [0-9]+\.[0-9]+\.[0-9]+' | awk '{print $1 "@" $2}' > Pnpmfile && success "Updated Pnpmfile."
fnm list | grep -Eo '(v[0-9]+\.[0-9]+\.[0-9]+)( [A-Za-z0-9_]+)?' | awk '{print $1, $2}' > Fnmfile && success "Updated Fnmfile."
python -m pip freeze > requirements.txt && success "Updated requirements.txt."
sd "macOS-([\d\.]*)" "macOS-$(sw_vers -productVersion)" README.md
info "Dotfiles updated."
