#!/usr/bin/env bash
# 
# update.sh - update dotfiles

# Ensure required commands are available
cmds=(brew fnm npm pip3 git gum)
for cmd in ${cmds[@]}; do
    if ! command -v $cmd &> /dev/null; then
        echo "Update failed: required command \`$cmd\` not found"
        exit 1
    fi
done

success() {
    gum style --foreground=2 "✓ $1"
}

fail() {
    gum style --foreground=1 "✗ $1"
}

warn() {
    gum style --foreground=3 "* $1"
}

info() {
    gum style --foreground=4 "i $1"
}

gum spin --spinner.foreground="255" --title "Updating Brewfile..." -- brew bundle dump --force && success "Updated Brewfile."

node_versions=$(fnm list | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
node_current=$(fnm current)
for v in $node_versions; do
    fnm use $v &> /dev/null
    npm list --global --parseable --depth=0 | sed '1d' |awk -F"/node_modules/" '{print $2}' > Npmfile-$v && success "Updated Npmfile-$v."
done
fnm use $node_current &> /dev/null
gum spin --spinner.foreground="255" --show-output --title "Updating Fnmfile..." -- fnm list | grep -Eo '(v[0-9]+\.[0-9]+\.[0-9]+)( [A-Za-z0-9_]+)?' | awk '{print $1, $2}' > Fnmfile && success "Updated Fnmfile."
gum spin --spinner.foreground="255" --show-output --title "Updating requirements.txt..." -- python -m pip freeze > requirements.txt && success "Updated requirements.txt."
info "Done! Dotfiles updated."
echo -en "\033[0;36m? Commit and push? [y/N] \033[0m"
read -r -n 1 response
echo
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    git add . && git commit -m "chore: update dotfiles" && git push && success "Changes committed." || fail "Changes not committed."
else
    warn "Changes unsaved."
fi