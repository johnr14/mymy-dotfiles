###############################################################################
#
# Bashrc and associated files
# Lot's from internet, so GPL 3.0
# jonathanrioux@gmail.com
#
# TODO
# First run check
# Update from github
# Prompt cleanup
# Fix completition - sudo is fixed
# while in sudo, some caracters are not removed from prompt when pressing up/down
# Update terminal name with user@host%APP running
# Time all command run
#Use .bashrc from sudoed account
#
# FIXME
# in "sudo su" bash doesn't reload bash_functions
# when doing a sudo, pass $SSH_CLIENT
#
# Dependency
# dfc expect neofetch xclip net-tools dnsutils(host,dig)
#
# Personal notes for github
# If README.md was updated on github : 
#   git pull origin master
# Push changes to github
#   git push origin master
# 
# LOG ROOT cmd https://unix.stackexchange.com/questions/257303/confirmation-before-sudo-su/257309
# readonly PROMPT_COMMAND='history -a >(logger -t "commandlog $USER[$PWD] $SSH_CONNECTION")' 
###############################################################################

#TO FIX !!!!!!!!! MAJOR
#To reevaluate values, you must put a \ before the $() ; so it isn't expanded immediately
#https://stackoverflow.com/questions/5379986/why-doesnt-my-bash-prompt-update


# $PATH seem to have dupplicates

###############################################################################
# General configuration
###############################################################################

# FIXME 
# IF ROOT, FIX $PATH
# PATH="/sbin:$PATH"

# If not running interactively, don't do anything
# Should path be fixed first ?
case $- in
    *i*) ;;
      *) return;;
esac

# Warn if $HOSTNAME != hostnamectl; needed in some VM
if [[ -f /usr/bin/hostnamectl ]]; then
    if [[ "$(hostnamectl --static)" != "$HOSTNAME" ]]; then
        echo "WARNING: Hostname is not the same as the variable \$HOSTNAME"
        echo "Trying to change it"
        if [ $(hostnamectl set-hostname --static $HOSTNAME) != 0 ]; then
            echo "Was not able to change it"
        else
            echo "New hostname is set $(hostnamectl)"
        fi
    fi
fi

#############################
# First run check
#############################

#Test if folder .mymybash exist
# If not exist :
#   install needed applications
#       dfc htop pv git screen tmux xclip net-tools tuptime neofetch expect curl colordiff lsof inxi
#       Download from github all files needed
#       If successfull, create file .bashrc-mymybash
#           File will hold personal variables in the futur

if [ ! -d $HOME/.bash_histories ]; then
clear
echo ""
echo "This is your first run of mymy-dotfiles"
echo "A lot of aliases are added for ease of use. To search, use alias-search WORD"
echo "Also, it will not work with non english system. To enforce it, it sets LC_ALL=C"
echo ""
echo ""
fi



###############################
# Set things up
###############################


#######################
# Load files
#######################
# Use realuser for homedir so it can work when in "sudo su"

if [[ "$LOGNAME" = "root" ]]; then
  if [ -f /root/.bash_aliases ]; then 
      DOTFILES_PATH="$HOME"
  else 
    DOTFILES_PATH="/home/$LOGNAME"
  fi
else
    DOTFILES_PATH="/home/$LOGNAME"
fi

if [ -f $DOTFILES_PATH/.bash_aliases ]; then
    . $DOTFILES_PATH/.bash_aliases
fi

if [ -f $DOTFILES_PATH/.bash_functions ]; then
    . $DOTFILES_PATH/.bash_functions
fi

# FIXME file was not created !
if [ -f $DOTFILES_PATH/.bash_autocompletition ]; then
    . $DOTFILES_PATH/.bash_autocompletition
fi

#######################
# Conditionnal files
#######################

###############
# Qubes OS
###############

if [ -f $DOTFILES_PATH/.bash_functions_qubesos ]; then
    . $DOTFILES_PATH/.bash_functions_qubesos
fi


#######################
# Set language
#######################

export LANG=en_US.UTF-8
export LC_ALL=C


#######################
# Set terminal
#######################
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

shopt -s expand_aliases 

#######################
# Set defaults
#######################

# Set the default editor to vim.
export EDITOR=vim

# Support multithread for XZ
export XZ_DEFAULTS="-T 0"

#######################
# Set autocomplete
#######################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

shopt -s cdspell  

# Needed for sudo completition, see https://askubuntu.com/questions/874179/sudo-command-doesnt-autocomplete-anymore-on-files
complete -cf sudo

#######################
# Set path
#######################

#TODO CHECK IF ALREADY EXISTING !!
PATH="$DOTFILES_PATH/bin:$PATH"
# Remove path dupplicates
__fixpath


# for flatpak
XDG_DATA_DIRS="${XDG_DATA_DIRS:-$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share/:/usr/local/share/:/usr/share/}" #"

#######################
# Colors
#######################

# Is this still needed ?
if [ "$TERM" == "rxvt-unicode-256color" ]; then
    export TERM=rxvt-256color
else
     export TERM=xterm-color
fi

#Force color
case "$TERM" in
    xterm)
        color_prompt=yes
        ;;
    xterm-colors)
        color_prompt=yes
        ;;
    screen)
        color_prompt=yes
        ;;
    *256*) 
        color_prompt=yes
        ;;
esac

export TERM=xterm

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

#######################
# Misc
#######################

# no bell
set bell-style none

###############################
# Log out policy
###############################

###############
# IS user ROOT?
###############
# Safety policy !
# Never leave idle root login open !
# However, if you are in nested bash->bash->bash, it will not work
if (( $EUID == 0 )); then
    # set a 5 min timeout policy for bash shell
    TMOUT=300
    #readonly TMOUT 2> /dev/null 
    export TMOUT 2> /dev/null 
fi


#################
# SSH idle logout
#################

# Only log out if attached to a tmux or screen
# TODO

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # set a 10 min timeout policy for bash shell
    TMOUT=600
    #readonly TMOUT 2> /dev/null
    export TMOUT 2> /dev/null
fi

#############################
# History control
#############################

# Keep 1000 lines in .bash_history (default is 500)
export HISTSIZE=100000 # big big history
export HISTFILESIZE=1000000 # big big history filesize

export HISTCONTROL="erasedups:ignoreboth:ignoredups" # Stop bash from caching duplicate lines.
export HISTIGNORE="&:[ ]*:exit:ls:clear:df:dfc:pwd" # Remove from history

shopt -s histappend                      # append to history, don't overwrite it
shopt -s cmdhist                         #This lets you save multi-line commands to the history as one command.
shopt -s histverify                      # Show expanded history before running it.

#https://superuser.com/questions/247770/how-to-expand-aliases-inline-in-bash
shopt -s direxpand
shopt -s expand_aliases

#STANDARD :
export HISTFILE="$HOME/.bash_history" # reset the file
export HISTTIMEFORMAT="%d/%m/%y %T " # Timestamp the bash history
export PROMPT_COMMAND='history -a; history -c; history -r;'

#################
# Multi history
#################

#FIXME THIS PART IS NOT FINALISED !!
# TODO : 
#       
#       SEARCH HISTORY : by pwd, by cmd, by time, by tmuxname, by hostname
#       View pwd history
#       

# make sure directory is created
mkdir -p $HOME/.bash_histories 

# Get terminal name
# https://askubuntu.com/questions/476641/how-can-i-get-the-name-of-the-current-terminal-from-command-line
#TERMNAME="$($(ps -p $(ps -p $$ -o ppid=) o args=) --version 2> /dev/null | sed 's/[1-9.-\ ].*//')"
TERMNAME="$(basename $(ps -p $(ps -p $$ -o ppid=) o args=))"


#NOTICE THE WEIRD NAMING, ONLY WORKS ON UNIX
if [ "$(id -u)" -ne 0 ]; then # We are not root
    if [ -n "$TMUX" ] && [ ! -n "$SSH_CLIENT" ]; then # We are in a TMUX but not from a ssh client 
        #Let's have a history per pane of tmux
        UNIQTTY="tmux_$(tmuxcpa)"

        if [ "$TERMNAME" == "tmux" ]; then
            UNIQTTYNAME="${TERMNAME}_$(tmuxcpa)"
    else
            UNIQTTYNAME="tmux_$(tmuxcpa)"
        fi
    elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        #We are in a SSH login and not in tmux 
        REMOTEIP=$(echo $SSH_CLIENT | awk '{print $1}')
        if [ -n "$TMUX" ]; then
            UNIQTTY="$REMOTEIP@ssh>tmux_$(tmuxcpa)" # keep per pane also
            if [ -n "$TERMNAME" ]; then
                UNIQTTYNAME="$TERMNAME_tmux_$(tmuxcpa)"
            else
                UNIQTTYNAME="tmux_$(tmuxcpa)"
            fi
        else
            UNIQTTY="$REMOTEIP@ssh>pts_$(__ttyc)"
            if [ -n "$TERMNAME" ]; then
                UNIQTTYNAME="$TERMNAME_pts_$(__ttyc)"
            else
                UNIQTTYNAME="pts_$(__ttyc)"
            fi
        fi
    else 
        #We are not in tmux or ssh
        INPTS=$(tty | grep pts)
        if [ ! -z $INPTS ]; then 
            # We have a pts
            UNIQTTY="pts=$(__ttyc)"
            if [ -n "$TERMNAME" ]; then
                UNIQTTYNAME="${TERMNAME}_pts_$(__ttyc)"
            else
                UNIQTTYNAME="pts_$(__ttyc)"
            fi
        else
            # Not using pts, then a real tty
            UNIQTTY="tty=$(__ttyc)"

            if [ -n "$TERMNAME" ]; then
                UNIQTTYNAME="${TERMNAME}_tty_$(__ttyc)"
            else
                UNIQTTYNAME="tty_$(__ttyc)"
            fi

        fi
    fi

    export HISTTIMEFORMAT=""

    # We write direcly to the merged history file from the command prompt 

    export PROMPT_COMMAND=' history -a; history -c; history -r; if [ -n "$(LC_ALL=C type -t __history1)" ] && [ "$(LC_ALL=C type -t __history1)" = function ]; then :; else . /home/$LOGNAME/.bashrc; fi; echo "\"$(date "+%Y-%m-%d.%H:%M:%S")\" \"$UNIQTTYNAME\" \"$HOSTNAME\" \"$(pwd)\" $(__history1) " >> /home/$LOGNAME/.bash_history-merged'
    export HISTFILE="/home/$LOGNAME/.bash_histories/$UNIQTTYNAME" # reset the file

else
    # we are user root
    if [[ "$LOGNAME" = "root" ]]; then
        # This means mymy-bash was installed in root user !
        export PROMPT_COMMAND=' history -a; history -c; history -r; echo "\"$(date "+%Y-%m-%d.%H:%M:%S")\" \"$UNIQTTY\" \"$HOSTNAME\" \"$(pwd)\" $(__history1) " >> /root/.bash_history-merged'
        export HISTFILE="/root/.bash_histories/$UNIQTTYNAME" # reset the file
    else
        # we are root but it was thru a sudo su
        # check that bash_functions is loaded
        if [ -n "$(LC_ALL=C type -t __history1)" ] && [ "$(LC_ALL=C type -t __history1)" = function ]; then 
            . /home/$LOGNAME/.bash_functions
        else 
            . $DOTFILES_PATH/.bashrc
            #. /home/$LOGNAME/.bashrc
        fi
        mkdir -p /root/.bash_histories # make sure the directory exist
        export PROMPT_COMMAND=' history -a; history -c; history -r; if [ -n "$(LC_ALL=C type -t __history1)" ] && [ "$(LC_ALL=C type -t __history1)" = function ]; then :; else . /home/$LOGNAME/.bashrc; fi; echo "\"$(date "+%Y-%m-%d.%H:%M:%S")\" \"$UNIQTTYNAME\" \"$HOSTNAME\" \"$(pwd)\" $(__history1) " >> /root/.bash_history-merged'
        export HISTFILE="/root/.bash_histories/$UNIQTTYNAME" # reset the file
        #export PROMPT_COMMAND=' history -a; history -c; history -r; echo "\"$(date "+%Y-%m-%d.%H:%M:%S")\" \"$UNIQTTY\" \"$HOSTNAME\" \"$(pwd)\" $(__history1) " >> /home/$LOGNAME/.bash_history-merged'
        #export HISTFILE="/home/$LOGNAME/.bash_histories/$UNIQTTYNAME" # reset the file
    fi
fi
#export HISTTIMEFORMAT="$HOSTNAME $UNIQTTY %d/%m/%y %T : " #Timestamp the bash history

# check if folder .logs exist
#export PROMPT_COMMAND='history -a; history -c; history -r; if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(__history1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'






#https://askubuntu.com/questions/59846/bash-history-search-partial-up-arrow
#bind '"\e[A": history-search-backward' 
#bind '"\e[B": history-search-forward'

###############
# TMUX
###############

# Create models of tmux configs
# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened

#Check if we where launched in a tmux and rename session
if [[ $(__tmux-isrunning) ]]; then
    if [[ -n $TMUX ]]; then
        #echo "We have at least a tmux running and we are in it"
        re='^[0-9]+$'
        if [[ $(tmux display-message -p '#S') =~ $re ]]; then
            #echo "we have a numeric session name"
            # check if session name is already taken
            alreadyrunninginterm=$(tmux list-client | grep -F $(__tmux-termfullnameandpid))
            nextnb=$(echo $alreadyrunninginterm | wc -l)
            ((nextnb++))
            if [[ -n $alreadyrunninginterm ]]; then
                #echo "We must append to the name"
                tmux rename-session -t $(tmux display-message -p '#S') $(__tmux-termfullnameandpid)-$nextnb
            else
                #echo "we can use tha name"
                tmux rename-session -t $(tmux display-message -p '#S') $(__tmux-termfullnameandpid)
            fi
        fi
    fi
fi
###############################################################################
# X11
###############################################################################

# Find if running X11 or Wayland
# echo $XDG_SESSION_TYPE

#GUI RELATED
# Allow local users to use my X session
# xhost +local:

# TODO copy Xauthority if sudo 
# [ -f "$oldhome/.Xauthority" ] && export XAUTHORITY=$oldhome/.Xauthority

#############################
# Functions
#############################

# Find all connections to ssh port
# ss -nt | grep -Po "(\d|\.)+:22\s+\K[^:]+"

###############
# SSH
###############

# https://github.com/alexshvid/sshrc
# BRING YOUR bashrc with you on a connected host !!!! TODO

function is_ssh {
#case "/$(ps -p $PPID -o comm=)" in
#  */sshd) screen -R -d;;
#esac

#https://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
#If one of the variables SSH_CLIENT or SSH_TTY is defined, it's an ssh session.
#If the login shell's parent process name is sshd, it's an ssh session.
# $SSH_CONNECTION has from IP to IP and PORTS
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
  REMOTEIP=$(echo $SSH_CLIENT | awk '{print $1}')
# many other tests omitted
else
  #Check if running as root
  if (( $EUID == 0 )); then
    #ROOT from sudo ? get the ip from pinky (quick hack)
    ROOTPTS=$(who am i | awk '{ print $6}' | sed -e 's/(:\(.*\):.*)/\1/')
    if [ -z "$ROOTPTS" ]; then
        REMOTEIP=$(pinky | grep -e "*"$ROOTPTS | awk '{print $6}')
        SESSION_TYPE=remote/ssh
    fi
  fi
fi
}

# TODO Log cmd run from ssh differently

#PROMPT_COMMAND='history -a; history -c; history -r; ssh_ip=`echo $SSH_CLIENT|awk "{print \\\$1}"`; echo "#command above was run from PPID $PPID, IP $ssh_ip" >>~/.bash_history'

#######
# SSH
#######

# TODO

#Automatically attach to tmux if login from ssh 
#if [ -z "$TMUX" ]; then
#    tmux attach -t Default || tmux new -s Default
#fi


###############
#
###############
function exitstatus {

    EXITSTATUS="$?"
    BOLD="\[\033[1m\]"
    RED="\[\033[0;31m\]"
    GREEN="\[\e[0;32m\]"
    BLUE="\[\e[34m\]"
    OFF="\[\033[m\]"

    HOST="\h"
    USER="\u"
    DIR="\w"
    NEWLINE="\n"
    DATE="\d"
    TIME="\t"

    PROMPT="\[\033]0;${USER}@${HOST}: \w\007\n${RED}${TIME} ${DATE} [${USER}@${HOST}:[${BLUE}\w${RED}]"

    if [ "${EXITSTATUS}" -eq 0 ]
    then
        PS1="${PROMPT} [${GREEN}${EXITSTATUS}${RED}]${OFF}\n$ "
    else
        PS1="${PROMPT} [${BOLD}${EXITSTATUS}${RED}]${OFF}\n$ "
    fi

    PS2="${BOLD}>${OFF} "
}







#############################
# Prompt
##############################
#Bash Prompt !
# TODO : ROOT SPACE IN RED IF <25%
# USER ID IN RED IF ROOT
# original USER if in SUDO 

# Replace JOBS with SCREEN
# Are you connected from remote in ssh ?
# Time run commands
# Return code
# Cache promt for zsh time update



###############################################################################
# Prompt
###############################################################################

#Must encapsulate in \[ \] https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
#PROMPT COLORS
PR_BLACK='\[\e[0;30m\]'
PR_BLUE='\[\e[0;34m\]'
PR_GREEN='\[\e[0;32m\]'
PR_CYAN='\[\e[0;36m\]'
PR_RED='\[\e[0;31m\]'
PR_PURPLE='\[\e[0;35m\]'
PR_BROWN='\[\e[0;33m\]'
PR_LIGHTGRAY='\[\e[0;37m\]'
PR_DARKGRAY='\[\e[1;30m\]'
PR_LIGHTBLUE='\[\e[1;34m\]'
PR_LIGHTGREEN='\[\e[1;32m\]'
PR_LIGHTCYAN='\[\e[1;36m\]'
PR_LIGHTRED='\[\e[1;31m\]'
PR_MAGENTA='\[\e[1;35m\]'
PR_YELLOW='\[\e[1;33m\]'
PR_LIGHTYELLOW='\[\e[0;93m\]'
PR_WHITE='\[\e[1;37m\]'
PR_NC='\[\e[0m\]' # No Color
PR_OFF="\[\033[m\]"

###############
# Variables
###############
#striked colors
SGREEN='\[\e[9;32m\]'
SYELLOW='\[\e[9;33m\]'


HOST="\h"
USERNAME="$USER"
DIR="\w"
NEWLINE="\n"
DATE="\d"
TIME="\t"

STRIKE="\[\e[9m\]"

#echo -e "\e[1mbold\e[0m"
#echo -e "\e[3mitalic\e[0m"
#echo -e "\e[4munderline\e[0m"
#echo -e "\e[9mstrikethrough\e[0m"
#echo -e "\e[31mHello World\e[0m"
#echo -e "\x1B[31mHello World\e[0m"

REALUSER=$LOGNAME # If in sudo, who are you logged as
#REALUSER=$(who am i | awk '{print $1}'
if [[ ! -z "$STY" ]]; then
    MULTNAME="¤$(echo $STY | sed -e 's/.*\.\(.*\)\..*/\1/')" # If in a screen, what's the name
fi

# Are we sshed to this host ?
# TODO

###############
# Function helper
###############

#Check if running as root
if (( $EUID == 0 )); then
    USERNAME="${SYELLOW}$REALUSER${OFF}>${RED}$USER"
    PROMPTSYMBOL="\[${RED}\]#"
else
    PROMPTSYMBOL="\[${GREEN}\]$"
    if [[ ! -z $REALUSER && $REALUSER != $USER ]]; then 
        USERNAME="${SGREEN}$REALUSER${OFF}${WHITE}>${LIGHTYELLOW}$USER${OFF}"
    else
        USERNAME=$USER
    fi
fi



###############
# Prompt build
###############

# COLORS SELECTION :
# FIXME
#   IN BASH
# (ps -o comm= -p "$PPID")
# tty
#   IN X
# basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//')
#   IN SSH
#   IN SCREEN
#   IN TMUX
#   LAST CMD RUNTIME
#   LAST CMD RETURN CODE

UPTIME_STR=$(awk '{print int($1/86400)"d "int($1%86400/3600)"h "int(($1%3600)/60)"m "int($1%60)"s"}' /proc/uptime)

PS1="${PR_OFF}"
#Timestamp
PS1+="\[${PR_WHITE}\](\[${PR_LIGHTCYAN}\]\D{%Y.%m.%d} \t\[${PR_WHITE}\])"
PS1+=""
PS1+="\[${PR_WHITE}\](\[${PR_LIGHTYELLOW}\]${UPTIME_STR}\[${PR_WHITE}\])" # CPU FIXME USE UPTIME uptime|awk '{ print $(NF-2) }'

#PS1+="\[${DARKGRAY}\]|\[${MAGENTA}\]Jobs:\j" #Jobs
PS1+="\[${PR_WHITE}\](\[${PR_MAGENTA}\]Net:\$(cat /proc/net/tcp | wc -l)"  # Network Connections
PS1+="\[${PR_WHITE}\]|\[${PR_MAGENTA}\]Users:\$(w -f -i -s -h | awk '{print \$1}' | sort | uniq -c | sed 's/^ *//' | sed 's/  */-/g' | tr '\n' ';'  | sed 's/;$//' )"
PS1+="\[${PR_WHITE}\])"
PS1+="\[${PR_WHITE}\](\[\e[32;1m\]\$(df -h / | tail -1 | awk 'END {print \"Root:\" \$3 \"/\" \$2}')"
PS1+="\[${PR_WHITE}\]"
PS1+=")(\[\e[32;1m\]\$(ls -ld */ 2>/dev/null | wc -l) dir, \$(find . -maxdepth 1 -type f 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files\[${PR_WHITE}\])\n" #, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"
#PS1+=")(\[\e[32;1m\]\$(find . -maxdepth 1 -t d 2>/dev/null | wc -l) dir, \$(/bin/ls -1 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"

## {USER@HOSTNAME:/PATH}
PS1+=" ${PR_WHITE}{"
PS1+="\[${PR_YELLOW}\]${USERNAME}"
PS1+="${PR_LIGHTCYAN}@${PR_LIGHTGREEN}$HOSTNAME"
PS1+="${PR_PURPLE}$MULTNAME" # Append screen name if in a screen
PS1+="${PR_LIGHTBLUE}:$DIR" #PATH
PS1+="\[${PR_WHITE}\]} ${PROMPTSYMBOL} "
PS1+="${PR_OFF}"

#PS1+=' \[\033[m\]{\[\e[32;1m\]\u\[\e[34;1m\]@\[\e[36;1m\]\H:\[\e[34;1m\]\w\[\033[m\]} \[\e[32;1m\]\$ \[\e[m\]\[\e[0;32m\]'

#TODO
#SCREEN NAME IF IN SCREEN/TMUX and # of screens/tmux unconnected; GIT; RED # if root; time of last cmd;
#Is X configured (to where?);

#https://unix.stackexchange.com/questions/60459/how-to-make-bash-put-prompt-on-a-new-line-after-cat-command
#shopt -s promptvars
#PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1
# this seems to cause some bugs, must investigate more ...

###############################################################################
# Informations and nice hacks
###############################################################################


###############################
# Cool hacks
###############################
# https://stackoverflow.com/questions/9747952/pane-title-in-tmux
# Scroling region using tput 

# Add right prompt https://wiki.archlinux.org/index.php/Bash/Prompt_customization
#rightprompt()
#{
#    printf "%*s" $COLUMNS "right prompt"
#}

#PS1='\[$(tput sc; rightprompt; tput rc)\]left prompt > '
































