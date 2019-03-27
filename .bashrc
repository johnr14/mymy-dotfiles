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
# Fix completition
# Update terminal name with user@host%APP running
# Time all command run
#Use .bashrc from sudoed account
#
# FIXME
# when doing a sudo, pass $SSH_CLIENT
#
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

###############################################################################
# General configuration
###############################################################################

# FIXME 
# IF ROOT, FIX $PATH
# PATH="/sbin:$PATH"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#############################
# First run check
#############################

#Test if folder .mymybash exist
# If not exist :
#   install needed applications
#       dfc htop pv git screen tmux xclip net-tools tuptime neofetch expect curl colordiff lsof
#       Download from github all files needed
#       If successfull, create file .bashrc-mymybash
#           File will hold personal variables in the futur


###############################
# Set things up
###############################

#######################
# Load files
#######################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_autocompletition ]; then
    . ~/.bash_autocompletition
fi

#######################
# Set language
#######################

export LANG=en_US.UTF-8



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


#######################
# Set path
#######################

PATH="~/bin:$PATH"

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
    readonly TMOUT 2> /dev/null 
    export TMOUT 2> /dev/null 
fi


#################
# SSH idle logout
#################

# Only log out if attached to a tmux or screen
# TODO










#############################
# History control
#############################

# Keep 1000 lines in .bash_history (default is 500)
export HISTSIZE=100000 # big big history
export HISTFILESIZE=1000000 # big big history filesize

export HISTCONTROL="erasedups:ignoreboth:ignoredups" # Stop bash from caching duplicate lines.
export HISTIGNORE="&:[ ]*:exit:ls:clear:df:dfc" # Remove from history

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
#       

# make sure directory is created
mkdir -p $HOME/.bash_histories 

#NOTICE THE WEIRD NAMING, ONLY WORKS ON UNIX
if [ "$(id -u)" -ne 0 ]; then # We are not root
    if [ -n "$TMUX" ] && [ ! -n "$SSH_CLIENT" ]; then # We are in a TMUX but not from a ssh client 
        #Let's have a history per pane of tmux
        UNIQTTY="tmux_$(tmuxcpa)"
        UNIQTTYNAME="tmux_$(tmuxcpa)"
    elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        REMOTEIP=$(echo $SSH_CLIENT | awk '{print $1}')
        if [ -n "$TMUX" ]; then
            UNIQTTY="$REMOTEIP@ssh>tmux_$(tmuxcpa)" # keep per pane also
            UNIQTTYNAME="tmux_$(tmuxcpa)"
        else
            UNIQTTY="$REMOTEIP@ssh>pts_$(ttyc)"
            UNIQTTYNAME="pts_$(ttyc)"
        fi
    else 
        INPTS=$(tty | grep pts)
        if [ ! -z $INPTS ]; then 
            UNIQTTY="pts=$(ttyc)"
            UNIQTTYNAME="pts_$(ttyc)"
        else
            UNIQTTY="tty=$(ttyc)"
            UNIQTTYNAME="tty_$(ttyc)"
        fi
    fi
    export HISTTIMEFORMAT=""
    export PROMPT_COMMAND=' history -a; history -c; history -r; echo "\"$(date "+%Y-%m-%d.%H:%M:%S")\" \"$UNIQTTY\" \"$HOSTNAME\" \"$(pwd)\" $(__history1) " >> $HOME/.bash_history-merged'
    export HISTFILE="$HOME/.bash_histories/$UNIQTTYNAME" # reset the file
else # We are root
    # Check if in sudo
    # TODO
    #HISTFILE=~/.history/history.$$
   # export PROMPT_COMMAND='history -a; history -c; history -r;'
   echo ""
fi
#export HISTTIMEFORMAT="$HOSTNAME $UNIQTTY %d/%m/%y %T : " #Timestamp the bash history

# check if folder .logs exist
#export PROMPT_COMMAND='history -a; history -c; history -r; if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'






#https://askubuntu.com/questions/59846/bash-history-search-partial-up-arrow
#bind '"\e[A": history-search-backward' 
#bind '"\e[B": history-search-forward'

###############
# TMUX
###############

###############################################################################
# X11
###############################################################################

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

SGREEN='\[\e[9;32m\]'

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

REALUSER=$(logname) # If in sudo, who are you logged as
#REALUSER=$(who am i | awk '{print $1}'
if [[ ! -z "$STY" ]]; then
    MULTNAME="¤$(echo $STY | sed -e 's/.*\.\(.*\)\..*/\1/')" # If in a screen, what's the name
else
    MULTNAME=""
fi


###############
# Function helper
###############

#Check if running as root
if (( $EUID == 0 )); then
    USERNAME="${SGREEN}$REALUSER${OFF}>${RED}$USER"
    PROMPTSYMBOL="${RED}#"
else
    PROMPTSYMBOL="${GREEN}$"
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
#



PS1="${PR_OFF}"
PS1+="\[\e[30;1m\](\D{%Y.%m.%d} \t\[\e[30;1m\])"
PS1+=""
#PS1+="\[\e[30;1m\](\[\e[36;1m\]CPU:\$(__cpu)%" # CPU FIXME USE UPTIME uptime|awk '{ print $(NF-2) }'
#PS1+="\[${DARKGRAY}\]|\[${MAGENTA}\]Jobs:\j" #Jobs
PS1+="\[${PR_DARKGRAY}\](\[${PR_MAGENTA}\]Net:\$(cat /proc/net/tcp | wc -l)"  # Network Connections
PS1+="\[${PR_DARKGRAY}\]|\[${PR_MAGENTA}\]Users:\$(w -f -i -s -h | awk '{print \$1}' | sort | uniq -c | sed 's/^ *//' | sed 's/  */-/g' | tr '\n' ';'  | sed 's/;$//' )"
PS1+="\[\e[30;1m\])"
PS1+="\[\e[30;1m\](\[\e[32;1m\]\$(df -h / | tail -1 | awk 'END {print \"Root:\" \$3 \"/\" \$2}')"
PS1+="\[\e[30;1m\]"
PS1+=")(\[\e[32;1m\]\$(ls -ld */ 2>/dev/null | wc -l) dir, \$(find . -maxdepth 1 -type f 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files\[\e[30;1m\])\n" #, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"
#PS1+=")(\[\e[32;1m\]\$(find . -maxdepth 1 -t d 2>/dev/null | wc -l) dir, \$(/bin/ls -1 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"

## {USER@HOST:/PATH}
PS1+=" ${PR_DARKGRAY}{"
PS1+="${USERNAME}"
PS1+="${PR_LIGHTCYAN}@${PR_LIGHTGREEN}$HOST"
PS1+="${PR_PURPLE}$MULTNAME" # Append screen name if in a screen
PS1+="${PR_LIGHTBLUE}:$DIR" #PATH
PS1+="${PR_DARKGRAY}} ${PR_PROMPTSYMBOL} "
PS1+="${PR_OFF}"

#PS1+=' \[\033[m\]{\[\e[32;1m\]\u\[\e[34;1m\]@\[\e[36;1m\]\H:\[\e[34;1m\]\w\[\033[m\]} \[\e[32;1m\]\$ \[\e[m\]\[\e[0;32m\]'

#TODO
#SCREEN NAME IF IN SCREEN/TMUX and # of screens/tmux unconnected; GIT; RED # if root; time of last cmd;
#Is X configured (to where?);



###############################################################################
# Informations and nice hacks
###############################################################################


###############################
# Cool hacks
###############################
# https://stackoverflow.com/questions/9747952/pane-title-in-tmux
# Scroling region using tput 



































