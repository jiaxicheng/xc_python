
alias 4='vim ~/.bashrc'
alias 5='. ~/.bashrc'
alias 6='vim /etc/hosts'
alias l.='ls -d .* --color=auto'
alias la='ls -A'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias lt='ls -trgA'
alias vi='vim'
n1() { nc -w1 ${2:-localhost} ${1:?"Usage: n1 port host"} </dev/null >/dev/null 2>&1 && echo "success($?)" || echo "failure($?)"; }

