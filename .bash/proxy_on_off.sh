#!/bin/bash

# from https://wiki.archlinux.org/index.php/Proxy_settings
function proxy_on() {
    # 192.168.99.100 is for minikube
    export no_proxy="127.0.0.1,localhost,auiag.corp,iag.com.au,devlabs,192.168.64.0/24,localaddress,.localdomain.com,192.168.99.100,iagcloud.net,192.168.49.2,DB8B4788812536AC063DABFD95299A5C.gr7.ap-southeast-2.eks.amazonaws.com"
    export NO_PROXY=${no_proxy}

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi

        export http_proxy="http://$1/"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        echo "Proxy environment variable set."
        return 0
    fi

#    echo -n "username: "; read username
#    if [[ $username != "" ]]; then
#        echo -n "password: "
#        read -es password
#        local pre="$username:$password@"
#    fi
#
#    echo -n "server: "; read server
#    echo -n "port: "; read port
#    export http_proxy="http://$pre$server:$port/"
    export http_proxy="http://127.0.0.1:3128"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export RSYNC_PROXY=$http_proxy
    git config --global http.proxy ${http_proxy}
    git config --global https.proxy ${http_proxy}
    echo -e "Proxy environment variables set."
}

function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    unset no_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset RSYNC_PROXY
    unset NO_PROXY
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo -e "Proxy environment variables removed."
}

