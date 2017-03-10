typeset -a ealiases
ealiases=()

function permealias () 
{ 
  alias "$*";
  echo ealias "$*" >> ~/.oh-my-zsh/custom/zsh-ealiases.zsh
}
function ealias()
{
  alias $1
  ealiases+=(${1%%\=*})
}

function expand-ealias()
{
if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
    zle _expand_alias
    zle expand-word
fi
zle magic-space
}

zle -N expand-ealias

bindkey -M viins ' '    expand-ealias
bindkey -M emacs ' '    expand-ealias
bindkey -M viins '^ '   magic-space     # control-space to bypass completion
bindkey -M emacs '^ '   magic-space
bindkey -M isearch ' '  magic-space # normal space during searches
