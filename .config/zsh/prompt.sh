#
# Prompt (version 1)
#
autoload -Uz vcs_info colors
colors

precmd() {
    vcs_info
}

# 
setopt prompt_subst

IN_TMUX=$([ ".$TMUX" = "." ] && echo "" || echo "T")

# Make sure you set your hostname in osx with:
# sudo scutil --set HostName 'yourHostName'
# otherwise zsh will pick the DHCP hostname
PS1='  ${IN_TMUX} %{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%} ${vcs_info_msg_0_}
  %F{129}>%f '
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

zstyle ':vcs_info:*' enable git

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.
