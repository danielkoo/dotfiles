#!/bin/bash

# http://petdance.com/2013/04/my-bash-prompt-with-gitsvn-branchstatus-display/
# Adapted from from https://github.com/hoelzro/bashrc/blob/master/colors.sh

function __prompt
{
    # List of color variables that bash can use
    local BLACK="\[\033[0;30m\]"   # Black
    local DGREY="\[\033[1;30m\]"   # Dark Gray
    local RED="\[\033[0;31m\]"     # Red
    local LRED="\[\033[1;31m\]"    # Light Red
    local GREEN="\[\033[0;32m\]"   # Green
    local LGREEN="\[\033[1;32m\]"  # Light Green
    local BROWN="\[\033[0;33m\]"   # Brown
    local YELLOW="\[\033[1;33m\]"  # Yellow
    local BLUE="\[\033[0;34m\]"    # Blue
    local LBLUE="\[\033[1;34m\]"   # Light Blue
    local PURPLE="\[\033[0;35m\]"  # Purple
    local LPURPLE="\[\033[1;35m\]" # Light Purple
    local CYAN="\[\033[0;36m\]"    # Cyan
    local LCYAN="\[\033[1;36m\]"   # Light Cyan
    local LGREY="\[\033[0;37m\]"   # Light Gray
    local WHITE="\[\033[1;37m\]"   # White

    local RESET="\[\033[0m\]"      # Color reset
    local BOLD="\[\033[;1m\]"      # Bold

    # Base prompt
    # changed \w to \W - dank
    PS1="$LCYAN\h:$YELLOW\W$LCYAN \\\$$RESET "

    local dirty
    local branch

    # Look for Git status
    if git status &>/dev/null; then
        if git status -uno -s | grep -q . ; then
            dirty=1
        fi
        branch=$(git branch --color=never | sed -ne 's/* //p')

    # Look for Subversion status
    else
        svn_info=$( (svn info | grep ^URL) 2>/dev/null )
        if [[ ! -z "$svn_info" ]] ; then
            branch_pattern="^URL: .*/(branch(es)?|tags)/([^/]+)"
            trunk_pattern="^URL: .*/trunk(/.*)?$"
            if [[ $svn_info =~ $branch_pattern ]]; then
                branch=${BASH_REMATCH[3]}
            elif [[ $svn_info =~ $trunk_pattern ]]; then
                branch='trunk'
            else
                branch='SVN'
            fi
            dirty=$(svn status -q)
        fi
    fi

    if [[ ! -z "$branch" ]]; then
        local status_color
        if [[ -z "$dirty" ]] ; then
            status_color=$LGREEN
        else
            status_color=$LRED
        fi
        PS1="$LCYAN($BOLD$status_color$branch$LCYAN)$RESET $PS1"
    fi
}

if [[ -z "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND=__prompt
else
# remove any extra semi-colons, as can be found in OS X's /etc/bashrc
    ${PROMPT_COMMAND##;*}
    PROMPT_COMMAND="$PROMPT_COMMAND ; __prompt"
fi
__prompt

