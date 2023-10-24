Next steps:

- TERM=xterm-256color ssh $DST

- ln -s dotfiles/.config 
- ln -s dotfiles/.tmux.conf
- rm -rf .local/share/nvim

- Update your PS1 in ~/.bashrc like so:
  if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="\n \[\033[00;32m\] nix\[\033[0;36m\]@\h \[\033[00;34m\][\w] \n \[\033[0;31m\] \[\033[00;35m\]$\[\033[00m\] "
    alias v="nvim"
  fi

- Install nix (this will do a multi-user installation - you need root):
  $ sh <(curl -L https://nixos.org/nix/install) --daemon

- Run the nix shell to install all the tools you need:
  $ cd dotfiles/nix; nix-shell

- Start nvim so it installs the plugins 
