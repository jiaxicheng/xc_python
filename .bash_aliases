
alias 4='vim ~/.bash_aliases'
alias 5='. ~/.bashrc'
alias 6='vim /etc/hosts'
alias l.='ls -d .* --color=auto'
alias la='ls -A'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias lt='ls -trgA'
alias vi='vim'
alias cdpp='cd /usr/local/lib/python3.6/site-packages'
n1() { nc -w1 ${2:-localhost} ${1:?"Usage: n1 port host"} </dev/null >/dev/null 2>&1 && echo "success($?)" || echo "failure($?)"; }

export PYTHONPATH=/shared/python3/modules:$PYTHONPATH
