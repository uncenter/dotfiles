#!/usr/bin/env sh
# 
# update.sh - update dotfiles

cmds=(brew fnm npm pip3 git)
for cmd in ${cmds[@]}; do
    if ! command -v $cmd &> /dev/null; then
        echo "Update failed: required command \`$cmd\` not found"
        exit 1
    fi
done

echo "Updating Brewfile..."
brew bundle dump --force
node_versions=$(fnm list | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
node_current=$(fnm current)
for v in $node_versions; do
    fnm use $v &> /dev/null
    echo "Updating Npmfile-$v..."
    npm list --global --parseable --depth=0 | sed '1d' |awk -F"/node_modules/" '{print $2}' > Npmfile-$v
done
fnm use $node_current &> /dev/null
echo "Updating requirements.txt..."
pip3 freeze --user > requirements.txt
read -r -n 1 -p "Commit and push? [y/N] " response
echo
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    git add . && git commit -m "chore: update dotfiles" && git push
fi
