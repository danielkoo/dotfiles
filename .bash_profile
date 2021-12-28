
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

