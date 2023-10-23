alias kt1='ssh kt1'
alias kt2='ssh kt2'
alias kt3='ssh kt3'

alias h4='/opt/homebrew/bin/alacritty -e ssh h4'
alias h4a='/opt/homebrew/bin/alacritty -e ssh -A -J driode01@hadoop-prod-01 driode01@hadoop-prod-04'
alias h4at='/opt/homebrew/bin/alacritty -e ssh -A -J driode01@hadoop-prod-01 driode01@hadoop-prod-04 -t tmux a &'
alias jh4='ssh -A -J driode01@hadoop-prod-01 driode01@hadoop-prod-04 -t tmux a'
alias jpg='ssh -A -J driode01@hadoop-prod-07 ubuntu@prom-graf'

alias v1='ssh v1'
alias v2='ssh v2'

#alias tj='tmux detach 2>/dev/null ; ssh -t driode01@hadoop-prod-04.uit.tufts.edu "tmux attach"'
#alias tj='ssh -t driode01@hadoop-prod-04.uit.tufts.edu "tmux attach"'
alias tj='ssh -t h4 tmux a'
alias jbnotebooks='ssh -L 8895:hadoop-prod-04.uit.tufts.edu:8895 driode01@hadoop-prod-04.uit.tufts.edu'
alias jbhadoop='ssh driode01@hadoop-prod-04.uit.tufts.edu'
alias dvts='ssh dvts-dev1'

alias sup='sshuttle --dns -vr dvts-dev1 0/0'

alias tsup='tailscale up --exit-node=100.77.59.88; echo "UP (dviz)!"'
alias tsuphp='tailscale up --exit-node=100.127.93.93; echo "UP (hadoop)!"'
#alias tsup='tailscale up --exit-node=100.82.156.106; echo "UP (h4)!"'
alias tsdown='tailscale up --exit-node=; echo "down"'
