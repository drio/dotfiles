{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    tmux
    go_1_21
    git
    neovim
    nodejs
    jq 
    curl 
    bat 
    bash
    fzf
    neofetch
    openjdk
    tailscale
  ];

  EDITOR = "${pkgs.neovim}/bin/nvim";
  GIT_EDITOR = "${pkgs.neovim}/bin/nvim";

  # Before starting the shell
  shellHook = ''
    export PS1="\n \[\033[00;32m\] nix\[\033[0;36m\]@\h \[\033[00;34m\][\w] \n \[\033[0;31m\] \[\033[00;35m\]$\[\033[00m\] "
    alias v="nvim"
    [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  '';
}
