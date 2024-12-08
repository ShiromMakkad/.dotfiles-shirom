### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up history
HISTFILE=~/.zsh_history
HISTSIZE=12000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST  # Expire dup event first when trimming hist
setopt HIST_IGNORE_DUPS        # Do not record consecutive dup events
setopt HIST_IGNORE_SPACE       # Do not record event starting with a space
setopt appendhistory

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# Completions
zinit light ShiromMakkad/rust-zsh-completions
zinit light zsh-users/zsh-completions

autoload -U compinit; compinit

# Broken for now. Want to get this as part of fzf-tab: https://github.com/Aloxaf/fzf-tab/issues/341
# zinit light marlonrichert/zsh-autocomplete

zinit snippet OMZ::lib/clipboard.zsh
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zshzoo/cd-ls

# Use `zinit times` to benchmark plugin loads
# Add the following line above a `zinit` line to lazy load plugin
# zinit ice wait lucid

# Enable tmux popup for fzf-tab
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Solves zsh-vi-mode incompatibility: https://github.com/jeffreytse/zsh-vi-mode/issues/4
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# For tmux-yank
bindkey -e

eval "$(zoxide init --cmd cd zsh)"

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=hx

# Source all of my personal rc files
for file in ~/.personalrc/*; do
    source "$file"
done

alias cpy=clipcopy
alias pst=clippaste

alias ls='lsd'
alias la='ls -a'
alias ll='ls -al'

alias vim='nvim'
alias vimdiff='nvim -d'

alias gs="git status"

alias zet="zellij action new-tab -l"
alias zl="zellij"
