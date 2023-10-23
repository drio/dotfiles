alias vim=nvim

alias j='z'

alias dsa='/opt/homebrew/bin/alacritty -e ssh ds720 -t ./tmux/d/exec &'
alias ds='ssh ds720 -t /volume1/drio-volume/tmux/d/exec'
alias rf='ssh rufus -t /usr/local/bin/tmux a'
alias tt='ssh teton -t /usr/local/bin/tmux a'

alias sizeblame='du -sh * | sort -h'
# git helpers
alias gb="git branch"
alias gba="git branch -a"
alias gd="git diff"
alias gdm="gd | mdr"
alias gm="git commit -m"
alias gs="git status"
alias gc="git checkout"
alias gca="git commit --amend"
alias ga="git add"
alias gap="git add -p"
alias gk="gitk --all &"
# alias gl="git log --graph --pretty=format:'%h | %cr | %cn | %s'"
alias gl="git log --graph --pretty=format:'%h%C(yellow)%d%C(reset) | %cr | %cn | %s'"
alias gll="git lola"
alias gsync="echo 'fetch + pull origin';git fetch --all && git pull --all"
alias gd="git diff"
alias gdc="git diff --cached"
alias gg="git status"

alias kb="vim -O $HOME/.hammerspoon/init.lua $HOME/.config/karabiner.edn"
# alias TMUX sessions
alias tl='tmux ls'
alias ti='ssh -t ironfist tmux a'
alias ta='tmux attach'
alias tr='ssh -t rufus /usr/local/bin/tmux a'
alias trt='ssh -t rufusts /usr/local/bin/tmux a'
alias jr='ssh -t jump /usr/local/bin/tmux attach'

#alias ls='gls --color=auto --long --git'
alias ls='ls --color=auto'
alias ll='ls -l'

alias sz='source $HOME/.zshrc'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vv='cd ~drio/.config/nvim/;v .'
alias vz='cd ~drio/.config/zsh/;v .zshrc'

alias letsgo='make -f ~/dev/gothings/prj-init/Makefile bootstrap'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
