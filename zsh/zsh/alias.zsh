funcion save_alias() {
    local cmd=$1
    local dep_cmd=$2
    local alias_cmd=$2
    if [ -n "$3" ]; then
        alias_cmd="$3"
    fi
    if type $dep_cmd > /dev/null; then
        alias $cmd="$alias_cmd"
    fi
}

alias vi='nvim'
alias gvi='neovide --fork'
#alias tmux='tmux -2'
alias agi="sudo apt-get install -y"
alias gbk='iconv -f gbk -t utf8'

alias be='bindkey -e'
alias bv='bindkey -v'

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file

alias more='less'
alias wl='wc -l'
alias tf='tail -f'
alias cnter='sort | uniq -c | sort -nr'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| less"

alias dud='du -d 1 -h'
alias duf='du -sh *'
(( $+commands[fd] )) || alias fd='find . -type d -name'
alias ff='find . -type f -name'

save_alias sed gsed # mac 使用GNU sed
save_alias btop bpytop
save_alias p bpython

alias mc="make clean"
alias mck="mc && mk"
alias mi="make install"
if [ $(uname -s) = 'Linux' ]; then
    alias mk="make -j$(grep --count processor /proc/cpuinfo)"
else
    alias mk="make"
fi

alias wechat='/Applications/WeChat.app/Contents/MacOS/WeChat 2> /dev/null > /dev/null &'
