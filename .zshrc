# References:
# - https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# - https://github.com/Mach-OS/Machfiles/blob/master/zsh/.config/zsh/
# - https://github.com/adamyonk/dotfiles/blob/91f35492b8f84a33b1e545f440ffe10b982f9f37/.zshrc
#
# Bring bash crtl-x keybidings
bindkey -e #bindkey '^R' history-incremental-search-backward

# autojump setup
#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
# autojump deplace fasd for autocompletion: https://github.com/clvv/fasd
# eval "$(fasd --init auto)"
# eval "$(fasd --init zsh-wcomp-install zsh-hook zsh-ccomp)"

# export PATH=/Users/drio/local/nvim-macos/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/usr/local/bin:"/Applications/Visual Studio Code.app//Contents/Resources/app/bin"
export PATH=$PATH:/Applications/Hammerspoon.app/Contents/Frameworks/hs
#export PATH=$PATH:/opt/homebrew/Cellar/instantclient-sqlplus/19.8.0.0.0dbru/bin
export PATH=$PATH:/Applications/YubiKey\ Manager.app/Contents/MacOS

# load ssh key
# eval `ssh-agent`
# ssh-add ~/.ssh/id_rsa
#which keychain > /dev/null 2>&1
#if [[ ".$SSH_TTY" = "." && ($KEYCHAIN -eq 0)]];then
  #eval `keychain --eval --agents ssh --inherit any id_rsa`
  #eval `keychain --eval --agents ssh --inherit any id_rsa_git`
  #eval `keychain --eval --agents ssh --inherit any id_dsae
#fi

# History
#
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

function ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 50
}

# GIT
export GIT_AUTHOR_NAME="David Rio Deiros"
export GIT_COMMITTER_NAME="David Rio Deiros"
export GIT_AUTHOR_EMAIL="driodeiros@gmail.com"
export GIT_COMMITTER_EMAIL="driodeiros@gmail.com"

export EDITOR="nvim"

# nvm
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  #
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nv
}
# This take time to load
#load_nvm

# Google cloud
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

#
mkdir -p $HOME/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$HOME/.config/zsh/scripts

source $HOME/.config/zsh/zplug.sh

source $HOME/.config/zsh/prompt-spaceship.sh
#source $HOME/.config/zsh/promptv2.sh
#source $HOME/.config/zsh/prompt.sh

[ -f $HOME/.config/zsh/tufts.sh ] && source $HOME/.config/zsh/tufts.sh
source $HOME/.config/zsh/_alias.sh
source $HOME/.config/zsh/tmux.sh
source $HOME/.config/zsh/credentials.sh

_zh=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $_zh ] && source $_zh
_zh=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $_zh ] && source $_zh


# fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# fzf: Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# fzf: Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

eval "$(zoxide init zsh)"
