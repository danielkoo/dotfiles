#!/usr/bin/env bash

if [[ $(whoami) =~ ^s[0-9]* ]]; then
  IS_IAG_MACHINE=true
fi

if [[ -f /etc/bashrc && $OSTYPE != darwin* ]]
then
  source /etc/bashrc
fi

# explicitly defining this so it is clear we want as many configs as
# possible to go under here:
export XDG_CONFIG_HOME=~/.config

# the /etc/bashrc under OS X blindly appends $PROMPT_COMMAND to itself without
# checking it does contain something, which means we end up with a
# trailing '; ' that causes issues when PROMPT_COMMAND is appended to
# itself again later, so we try to strip that crap away:
# update_terminal_cwd is so we can open new tabs under the same dir
#export PROMPT_COMMAND="${PROMPT_COMMAND%%; *} ; update_terminal_cwd" # disabled because it causes new tabs in OS X Terminal to not retain the current dir

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

if [ -f ~/.bash/bash-completion.bash ]
then
  source ~/.bash/bash-completion.bash
fi

if [ -f ~/.bash/kubectl-completion.bash ]
then
  source ~/.bash/kubectl-completion.bash
fi

if [ -f ~/.bash/helm-completion.bash ]
then
  source ~/.bash/helm-completion.bash
fi

if [ -f ~/.bash/git-completion.bash ]
then
  source ~/.bash/git-completion.bash
fi

# do this if we're on an IAG machine
if $IS_IAG_MACHINE; then
#  export http_proxy=http:/localhost:3128
#  export https_proxy=${http_proxy}
#  export HTTP_PROXY=${http_proxy}
#  export HTTPS_PROXY=${http_proxy}
#  export no_proxy="localhost,127.0.0.1,10.*,*.auiag.corp,192.168.*,*.devlabs,*.iagcloud.net,localhost.localdomain,*.iaglimited.net,*.iagcloud,*.iag.com.au,localaddress,*.localdomain.com,*.local,169.254.169.254,*.internal,172.20.0.0/16"
#  export NO_PROXY=${no_proxy}

#  if [ -f ~/.bash/proxy_on_off.sh ]; then
#    source ~/.bash/proxy_on_off.sh
#  fi

# AWS CLI
  if [[ -f ~/.python-env/bin/activate ]]; then
    source ~/.python-env/bin/activate # access the locally-installed AWS CLI
  fi
fi

export AWS_DEFAULT_REGION=ap-southeast-2
if [ -f ~/.python-env/bin/aws_completer ]; then
    AWS_CLI=~/.python-env/bin/aws_completer
elif [ -f /usr/local/bin/aws_completer ]; then
    AWS_CLI=/usr/local/bin/aws_completer
elif [ -f /usr/local/aws/bin/aws_completer ]; then
    AWS_CLI=/usr/local/aws/bin/aws_completer
fi
if [[ $AWS_CLI ]]; then
    complete -C $AWS_CLI aws
fi

if [ -f /etc/environment ]
then
  source /etc/environment
fi

# aws-vault
if [ -f ~/.bash/aws-vault.sh ]
then
  source ~/.bash/aws-vault.sh
fi

export EDITOR=vim
export VISUAL=vim

# my own stuff
export PATH=~/bin:$PATH
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"

# Go
export PATH=~/go/bin:$PATH
export GOOS=darwin
export GOPATH=~/go

# for brew
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH

if [[ -f ~/perl5/perlbrew/etc/bashrc && $OSTYPE == darwin* ]]
then
    source ~/perl5/perlbrew/etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# set proxy for Git
if [ -n "$HTTP_PROXY" ]
then
    for i in http.proxy https.proxy
    do
        # set it only if it doesn't exist, otherwise all the iTerm tabs will all try to write to the git config file at the same time
#        if ! git config --global $i > /dev/null; then
#            git config --global $i $HTTP_PROXY
#        fi
        echo "making no proxy changes to the git config right now"
    done
fi

## Python
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#export PYTHONPATH=$PYTHONPATH:.
#if command -v pyenv 1>/dev/null 2>&1; then
#    eval "$(pyenv init -)"
#fi
#if which pyenv-virtualenv-init > /dev/null; then
#    eval "$(pyenv virtualenv-init -)"
#fi
#
## TODO optimise this load time
##eval "$(pipenv --completion)"

# for NPM https://docs.npmjs.com/misc/config
export npm_config_loglevel=info

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# always load asdf
#if { [[ "$TERM" == "screen"* ]] && [ -n "$TMUX" ]; } then
    #brew --prefix asdf is what used to run to give us thepath below, but it's so slow (v 2.2.0) at 1-5s *per call* that I'm hard-coding the path
#if { [[ "$TERM" == "xterm"* ]] && [ -z "$TMUX" ]; } then
#if [[ -n "$TMUX" ]]; then
    if [[ $(arch) == i386 ]]; then
        BREW_ASDF_PATH=/usr/local/opt/asdf
    else
        BREW_ASDF_PATH=/opt/homebrew/opt/asdf
    fi
    . "${BREW_ASDF_PATH}/asdf.sh"
    . "${BREW_ASDF_PATH}/etc/bash_completion.d/asdf.bash"
#fi


# suppress Catalina zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

#if $IS_IAG_MACHINE; then
#  proxy_on
#fi
