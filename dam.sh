# Display Attach Manager for tmux (remote) sessions
_dam_sessions ()
{
    COMPREPLY=();
    cur="${COMP_WORDS[COMP_CWORD]}";
    declare -A hostable;

    while IFS= read -r ahost; do                #get existing tmux session names
        ahost=${ahost%%":"*};                   #take first word split on colon
        hostable["${ahost}"]="";
    done < <(tmux ls 2>/dev/null); 
    while IFS= read -r ahost; do                #use known_hosts for possible completions
        [ "${ahost:0:1}" = "@" ] && continue;   #ignore @cert-authority and @revoked
        ahost=${ahost%%' '*};                   #take first word split on space
        ahost=${ahost%%','*};                   #take first word split on comma
        hostable["${ahost}/"]="";
    done < ~/.ssh/known_hosts;
    while IFS= read -r ahost; do                #ssh config for possible completions
        case "$ahost" in
            *'*'*) ahost="";;                   #ignore wild card hosts
            Host*) ahost="${ahost##*' '}";;     #last word split on space
            *) ahost="";;                       #ignore all else
        esac;
        hostable["${ahost}/"]="";               # lone / is legitimate argument
    done < ~/.ssh/config;

    case "${cur}" in
        */*)        #route connection via ssh
            damhost=${cur%%'/'*};
            thehost=${damhost:-$HOSTNAME};
            if ( command ssh -q -o BatchMode=yes $thehost true); then
                declare -A dam_hosted_sessions;
                while IFS= read -r asession; do
                    asession=${asession%%":"*};
                    dam_hosted_sessions["$damhost/${asession}"]=;
                done < <( command ssh -qt -o BatchMode=yes ${thehost} "tmux ls 2> /dev/null"); 
                dam_sessions="${!dam_hosted_sessions[@]}";
            else
                dam_sessions=${cur};        #can't ssh to host, assume user knows what they are doing
            fi
            ;;
        *)          #route connection locally
            dam_sessions="${!hostable[@]}";
            ;;
    esac

    COMPREPLY=( $(compgen -W "${dam_sessions}" -- $cur));
    return 0;
}
complete -o nospace -F _dam_sessions dam

dam () {
    DamHost=${1%%"/"*}                    #take first word split on slash
    DamHost=${DamHost:-$HOSTNAME};    #use default if no host before slash
    DamSess=${1##*"/"}                    #take last word split on slash
    DamSess=${DamSess:-"mine"};       #use default if no session after slash
    case "$1" in
        */*)
            [ "$TMUX" ] && tmux rename-window "$1"
            command ssh $DamHost -O check 2> /dev/null && ( timeout 3 ssh $DamHost exit || ssh $DamHost -O exit );
            command ssh -Aq $DamHost -t "tmux attach -dt $DamSess || tmux new -s $DamSess" 
            [ "$TMUX" ] && tmux set-window-option automatic-rename "on" 1>/dev/null
            ;;
        *)
            tmux attach -dt $DamSess || tmux new -s $DamSess
    esac

}
