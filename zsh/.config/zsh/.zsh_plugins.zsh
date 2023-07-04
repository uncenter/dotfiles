fpath+=( /Users/uncenter/.cache/antidote/ryanccn/vivid-zsh )
source /Users/uncenter/.cache/antidote/ryanccn/vivid-zsh/vivid-zsh.plugin.zsh
fpath+=( /Users/uncenter/.cache/antidote/hlissner/zsh-autopair )
source /Users/uncenter/.cache/antidote/hlissner/zsh-autopair/zsh-autopair.plugin.zsh
fpath+=( /Users/uncenter/.cache/antidote/zsh-users/zsh-completions/src )
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /Users/uncenter/.cache/antidote/romkatv/zsh-defer )
  source /Users/uncenter/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( /Users/uncenter/.cache/antidote/zsh-users/zsh-autosuggestions )
zsh-defer source /Users/uncenter/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /Users/uncenter/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source /Users/uncenter/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( /Users/uncenter/.cache/antidote/belak/zsh-utils/completion )
source /Users/uncenter/.cache/antidote/belak/zsh-utils/completion/completion.plugin.zsh
