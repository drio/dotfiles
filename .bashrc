parse_git_branc() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH=$PATH:/usr/local/bin:/bin

export EDITOR="vim"

# Load screen_stuff
export PATH=$PATH:/usr/bin

mkdir -p $HOME/.vim.swaps

# Git (this is duplicated in gitconfig)
export GIT_AUTHOR_NAME="David Rio Deiros"
export GIT_COMMITTER_NAME="David Rio Deiros"
export GIT_AUTHOR_EMAIL="driodeiros@gmail.com"
export GIT_COMMITTER_EMAIL="driodeiros@gmail.com"

alias rb="source $HOME/.bashrc"
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

alias my="mysql -uroot"
alias myd="mysqldump -uroot"

alias pullup="git co master && git pull"
alias be="bundle exec"

alias tmux_reload='tmux source-file $HOME/.tmux.conf'
alias tmuxi='tmux set -qg prefix C-t\; last'
alias tmuxo='tmux set -qg prefix C-w'

alias sb='source $HOME/.bashrc'


function git-rm-remote-branch {
  local _B=$(git rev-parse --abbrev-ref HEAD)
  if [ "$_B" == "master" ];then
		echo "I am not going to remove master branch"
	else
		echo "Branch to remove: $_B"
		echo "Press <enter> to continue ..."
		read _tmp
		git checkout master
		if [ ".$_B" != "." ];then
			echo "Deleting $_B locally"
			git branch -d $_B
			echo "Deleting $_B in origin"
			git push origin --delete $_B
		fi
	fi
}

function git-sweep-remote {
  git remote prune origin
  git branch --remotes --merged master | \
    sed "s/  origin\///" | \
    grep --color=auto -v 'master' | \
    xargs -n 1 -I '{}' -t git push origin :{}
}

function git-tag-next {
  PREV_TAG=`git describe | cut -d '-' -f 1`;
  TAG_PREFIX=`echo $PREV_TAG | sed -e 's/[0-9][0-9]*$//'`;
  CURR_TAG=`echo $PREV_TAG | sed -e 's/^[^0-9]*//'`;
  if [ -z $CURR_TAG ]; then
     echo "Can not parse tag!";
     return 1;
  fi;
  NEW_TAG=$(( $CURR_TAG + 1 ));
  NEW_TAG="${TAG_PREFIX}${NEW_TAG}";
  echo "Bumping tag from ${PREV_TAG} -> ${NEW_TAG}";
  MSG="$1";
  if [ -z "$MSG" ]; then
     MSG=$NEW_TAG;
  fi;
  git tag -a $NEW_TAG -m "${MSG}";
  echo "You can now run: git push origin ${NEW_TAG}"
  echo "Also, to deploy from slack:"
  echo "\$ lita shipit -b ${NEW_TAG} -a XXXXX -e production"
  echo "\$ lita shipit -b ${NEW_TAG} -a XXXXXX -e staging"
  # git push origin ${NEW_TAG}
}

function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fdh() {
	cd
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

v() {
	vim $(fzf)
}

# History
# when adding an item to history, delete itentical commands upstream
export HISTCONTROL=erasedups
# save 10000 items in history
export HISTSIZE=10000
# append history to ~\.bash_history when exiting shell
shopt -s histappend

# EC2
#export AWS_IAM_HOME=$HOME/ec2/IAM-cli
#export AWS_CREDENTIAL_FILE=$AWS_IAM_HOME/drio_cred.txt
#export EC2_HOME=$HOME/ec2/ec2-api-tools-1.4.0.2
#export JAVA_HOME=/Library/Java/Home
#export EC2_PRIVATE_KEY=~/.ec2/pk-IGD2V6RDMFYFPMJTPPCZAAZ5NSWXXY4N.pem
#export EC2_CERT=~/.ec2/cert-IGD2V6RDMFYFPMJTPPCZAAZ5NSWXXY4N.pem
#export PATH=$PATH:$EC2_HOME/bin

export NODE_PATH="/usr/local/lib/node_modules"

PATH=$HOME/Dropbox/git_repo:$PATH

alias clean_vim='rm -f $HOME/.vim/view/* $HOME/.vim/view/* $HOME/.vim/swp/* $HOME/.vim.swaps/*'

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE="on"
export GIT_PS1_SHOWUNTRACKEDFILES="on" 
export GIT_PS1_SHOWCOLORHINTS="on"
function color_my_prompt {
		local txtgrn='\e[0;32m' # Green
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\][\w]"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    #export PS1="\n   $__user_and_host $__cur_location\n $__last_color $__git_branch_color$__git_branch$__last_color$__prompt_tail$__last_color "
    #export PS1="\n   $__user_and_host $__cur_location\n $__last_color$(__git_ps1 " (%s)") $__prompt_tail $__last_color"
		export PS1='\n   \[\033[0;32m\]\u@\h \[\033[00;34m\][\w]\n \[\033[0;31m\] $(__git_ps1 " (%s)") \[\033[00;35m\]$\[\033[00m\] '
}
source $HOME/.git-prompt.sh
color_my_prompt

# Load specific stuff for this machine/user
touch $HOME/.bashrc_for_here
source $HOME/.bashrc_for_here

#export AWS_DEFAULT_PROFILE=drio

# local
export PATH=$PATH:$HOME/local

#if [ -s $HOME/.awsam/bash.rc ]; then
#  source $HOME/.awsam/bash.rc
#fi


#export PATH="$HOME/.yarn/bin:$PATH"
#export PATH="/Users/drio/Library/Python/3.7/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. /usr/local/etc/profile.d/z.sh
#source /usr/local//Cellar/fzf/0.24.0/shell/completion.bash
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# virtualenv and virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh
