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
sd "macOS-(\d*\.?\d+)" "macOS-$(sw_vers -productVersion)" README.md
info "Dotfiles updated."
echo -en "\033[0;36m? Begin commit process? (Y/n) \033[0m"
read -r -n 1 response
echo
if [[ ! $response =~ ^[Nn]$ ]]; then
    untracked_files=$(git ls-files --others --exclude-standard)
    if [ -n "$untracked_files" ]; then
        if [ "$(echo "$untracked_files" | wc -l)" -eq 1 ]; then
            file_to_add=$(echo "$untracked_files" | head -n 1)
            echo "You have an untracked file: $file_to_add"
            echo -en "\033[0;36m? Add '$file_to_add' to the commit? (y/N) \033[0m"
            read -r -n 1 response
            echo
            if [[ "$response" =~ ^[Yy]$ ]]; then
                git add "$file_to_add"
            fi
        else
            echo "You have untracked files. Select from below to add them to the commit:"
            gum choose --no-limit $untracked_files | while IFS= read -r line; do
                git add "$line"
            done
        fi
    fi
    git add -u
    staged=$(git diff --name-only --staged)
    if [ -z "$staged" ]; then
        echo "Nothing to save!"
        exit 0
    fi
    echo "Staged files:"
    while IFS= read -r line; do
        echo "- $line"
    done <<< "$staged"
    echo -en "\033[0;36m? Commit? (y/N) \033[0m"
    read -r -n 1 response
    echo
    if [[ $response =~ ^[Yy]$ ]]; then
        git commit -m "chore: update dotfiles" &> /dev/null && success "Changes committed." || fail "Changes not committed (something went wrong)."
    fi
else
    warn "Changes unsaved."
fi