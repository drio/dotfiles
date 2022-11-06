# zplug
export ZPLUG_HOME=$(brew --prefix)/opt/zplug # homebrew-installed zplug
source $ZPLUG_HOME/init.zsh
# Plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "spaceship-prompt/spaceship-vi-mode"
# zplug "mafredri/zsh-async", use:"async.zsh", hook-build:"ln -sf $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh $(brew --prefix)/share/zsh/site-functions/async"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load
