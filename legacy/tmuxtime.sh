#!/bin/sh
#
SESSION=0

ardmore() {
  ard_window=$(tmux list-window -t $SESSION: | grep ardmore | awk -F: '{print $1}')
  if [ ".$ard_window" != "." ];then
    echo "+ Killing ardmore window ..."
    tmux kill-window -t $SESSION:$ard_window
  fi
  tmux new-window -n ardmore -t $SESSION:
  ard_window=$(tmux list-window -t $SESSION: | grep ardmore | awk -F: '{print $1}')
  tmux send-keys -t $SESSION:$ardmore 'vpn' C-m
}


metricsjs() {
  name="metrics.js"
  window=$(tmux list-window -t $SESSION: | grep $name | awk -F: '{print $1}')
  if [ ".$window" != "." ];then
    tmux kill-window -t $SESSION:$window
  fi

  tmux new-window -n $name -t $SESSION:
  window=$(tmux list-window -t $SESSION: | grep $name | awk -F: '{print $1}')

  tmux split-window -h -t $SESSION:$window
  tmux send-keys -t $SESSION:$window.0 'cd $HOME/dev/librato/metrics.js; make' C-m
  #tmux send-keys -t $SESSION:$window.1 'cd $HOME/dev/librato/playground' C-m

  tmux split-window -v -t $SESSION:$window.0
  tmux split-window -v -t $SESSION:$window.1

  tmux send-keys -t $SESSION:$window.2 'cd $HOME/dev/librato/playground; python -m SimpleHTTPServer 8080 ' C-m
  tmux send-keys -t $SESSION:$window.3 'cd $HOME/dev/librato/playground' C-m
}


vim() {
  vim_window=$(tmux list-window -t $SESSION: | grep vim | awk -F: '{print $1}')
  if [ ".$vim_window" == "." ];then
    echo "+ Creating vim window ..."
    tmux new-window -n vim -t $SESSION:
    tmux send-keys -t $SESSION:$ardmore 'vim' C-m
  fi
}


mutt_irssi() {
  irssi_window=$(tmux list-window -t $SESSION: | grep irssi | awk -F: '{print $1}')
  if [ ".$irssi_window" != "." ];then
    tmux kill-window -t $SESSION:$irssi_window
  fi
  echo "+ Creating irssi window..."
  tmux new-window -n irssi -t $SESSION:
  irssi_window=$(tmux list-window -t $SESSION: | grep irssi | awk -F: '{print $1}')
  tmux split-window -h -t $SESSION:$irssi_window
  tmux send-keys -t $SESSION:$irssi_window.0 'mutt' C-m
  tmux send-keys -t $SESSION:$irssi_window.1 'ssh -t is tmux a' C-m
  tmux split-window -v -t $SESSION:$irssi_window.0
  tmux split-window -v -t $SESSION:$irssi_window.1
}


pis() {
  pis_window=$(tmux list-window -t $SESSION: | grep pis | awk -F: '{print $1}')
  if [ ".$pis_window" != "." ];then
    tmux kill-window -t $SESSION:$pis_window
  fi
  echo "+ Creating pis window..."
  tmux new-window -n pis -t $SESSION:
  pis_window=$(tmux list-window -t $SESSION: | grep pis | awk -F: '{print $1}')
  tmux split-window -h -t $SESSION:$pis_window
  tmux send-keys -t $SESSION:$pis_window.0 'ssh -t pi@192.168.1.232 tmux a' C-m
  tmux send-keys -t $SESSION:$pis_window.1 'ssh -t  -c aes256-ctr pi@192.168.1.132  tmux a' C-m

  tmux split-window -v -t $SESSION:$pis_window.1
  tmux send-keys -t $SESSION:$pis_window.2 'ssh -L127.0.0.1:9000:127.0.0.1:80 -c aes256-ctr root@192.168.1.1' C-m

  # Go to the vim window
  vim_window=$(tmux list-window -t $SESSION: | grep vim | awk -F: '{print $1}')
  tmux select-window -t $SESSION:$vim_window
}


setup() {
  vim
  #ardmore
  #mutt_irssi
  #pis

  # Go to the vim window
  vim_window=$(tmux list-window -t $SESSION: | grep vim | awk -F: '{print $1}')
  tmux select-window -t $SESSION:$vim_window
}


split() {
  vim_window=$(tmux list-window -t $SESSION: | grep vim | awk -F: '{print $1}')
  tmux split-window -t $SESSION:$vim_window
  tmux resize-pane -t $SESSION:$vim_window.1 -y 10
}


$1
