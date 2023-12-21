# TODO: detect IAG and set things up differently

alias gst='git st'
alias gg='git log --graph --decorate'
alias df='df -mH'


alias k='kubectl'
alias h='helm'
# IAG-specific
# alias k='kubectl --certificate-authority=/Users/dank/certs/iag-internal-ca.pem'
# alias h='helm --kube-ca-file=/Users/dank/certs/iag-internal-ca.pem'

# to enable completion on the k and h aliases:
complete -F __start_kubectl k
complete -F __start_helm h

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim -p'
alias cp='cp -i'
alias mv='mv -i'
alias ag='ag --hidden -a'
alias brew='brew -v'
alias cdqmk='cd /Users/dank/code/github/personal/qmk_firmware/keyboards/handwired/dactyl_manuform/4x6_5/keymaps/default'

#
if [[ $OSTYPE == darwin* ]]; then
    alias convert_epoch_time='date -r'
else
    # actually, this won't work - need a way to inject the '@' next to the epoch timestamp
    alias convert_epoch_time='date -d @'
fi

# IAG-specific
alias cdctl='cd /Users/dank/go/src/chuck.auiag.corp/devlabs/devlabsctl'
alias cdplans='cd /Users/dank/code/devlabs/devlabs-bamboo-plans/devlabs'

alias codefind='python3 $HOME/bin/codefind.py'

