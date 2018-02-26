# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias 2a='ssh -i ~/.ssh/rhel73_xjia.pem -fNL8080:localhost:8080 aws1'
alias 2ca='ssh -i ~/.ssh/id_rsa_sgrove chicago'
alias 2ec2='ssh -i ~/.ssh/rhel73_xjia.pem ec2-user@newyork'
alias 2ftp='ssh 192.168.1.144'
alias 2ny='ssh -i ~/.ssh/id_rsa_sgrove newyork'
alias 3='watch -d sar -dp 3'
alias 4='vim ~/.bashrc'
alias 5='. ~/.bashrc'
alias 6='vim /etc/hosts'
alias 7='ps aux | grep vpn'
alias apf='ps aux | grep [a]pache'
alias ccc='history -c'
alias cdapay='cd /home/xicheng/xicheng/apay/samples'
alias cdb='cd "/home/xicheng/xicheng/Bugs/New Lender/new_lender"'
alias cdc='cd /var/cache/mason'
alias cde='cd /etc/httpd'
alias ckip='lynx -dump http://www.raffar.com/checkip/ | grep '\''Your current IP Address:'\'''
alias cp='cp -i'
alias h='history 30'
alias l.='ls -d .* --color=auto'
alias la='ls -A'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias lt='ls -trgA'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias mv='mv -i'
alias qq='exit'
alias rm='rm -i'
alias rmold='command rm .*.sw[po] 2> /dev/null'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'


export TERM=xterm-color
export HADOOP_HOME=/home/bigdata/hadoop-latest
export PERL5LIB=/etc/httpd/lib:/etc/httpd/lib:$PERL5LIB

JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk.x86_64

# function to set terminal title
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  #PS1=${ORIG}${TITLE}
}
set-title $HOSTNAME

n1() { nc -w1 ${2:-localhost} ${1:?"Usage: n1 port host"} </dev/null >/dev/null 2>&1 && echo "success($?)" || echo "failure($?)"; }
n2() {  nc -w1 "$@" </dev/null >/dev/null 2>&1 && echo "success($?)" || echo "failure($?)"; }
p1() { ps np ${1:?"Usage: p1 <pid>"} | more; }

