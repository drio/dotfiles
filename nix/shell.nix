{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    tmux
    go
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
  ];

  EDITOR = "${pkgs.neovim}/bin/nvim";
  GIT_EDITOR = "${pkgs.neovim}/bin/nvim";

  # Before starting the shell
  shellHook = ''
    source ~/.bashrc
    [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  '';
}
