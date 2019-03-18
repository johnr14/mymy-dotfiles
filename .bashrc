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
# 
# LOG ROOT cmd https://unix.stackexchange.com/questions/257303/confirmation-before-sudo-su/257309
# readonly PROMPT_COMMAND='history -a >(logger -t "commandlog $USER[$PWD] $SSH_CONNECTION")' 
###############################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#############################
# First run check
#############################

#Test if file .bashrc-mymybash exist
# If not exist :
#   install needed applications
#       dfc htop pv git screen tmux xclip net-tools
#       Download from github all files needed
#       If successfull, create file .bashrc-mymybash
#           File will hold personal variables in the futur


###############################
# Set things up
###############################

#######################
# Load aliases
#######################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#######################
# Set language
#######################

export LANG=en_US.UTF-8
if [ "$TERM" == "rxvt-unicode-256color" ]; then
    export TERM=rxvt-256color
else
     export TERM=xterm-color
fi

#######################
# Set terminal
#######################

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

#######################
# Set autocomplete
#######################


# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'


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
if (( $EUID == 0 )); then
    # set a 5 min timeout policy for bash shell
    TMOUT=300
    readonly TMOUT
    export TMOUT
fi


###############
# SSH
###############


###############
# TMUX
###############

#Automatically attach to tmux
#if [ -z "$TMUX" ]; then
#    tmux attach -t Default || tmux new -s Default
#fi


#Force color
case "$TERM" in
    xterm)
        color_prompt=yes
        ;;
    screen)
        color_prompt=yes
        ;;
    *256*) 
        color_prompt=yes
        ;;
esac



#############################
# History control
#############################

# Keep 1000 lines in .bash_history (default is 500)
export HISTSIZE=100000 # big big history
export HISTFILESIZE=1000000 # big big history
export HISTTIMEFORMAT="%d/%m/%y %T " #Timestamp the bash history

#export HISTCONTROL="erasedups:ignoreboth" #Stop bash from caching duplicate lines.
#export HISTIGNORE="&:[ ]*:exit" #Remove from history
shopt -s histappend                      # append to history, don't overwrite it
shopt -s checkwinsize                    # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s cmdhist                         #This lets you save multi-line commands to the history as one command.
shopt -s histverify                      # Show expanded history before running it.
#PROMPT_COMMAND='history -a; history -c; history -r; ssh_ip=`echo $SSH_CLIENT|awk "{print \\\$1}"`; echo "#command above was run from PPID $PPID, IP $ssh_ip" >>~/.bash_history'
PROMPT_COMMAND='history -a; history -c; history -r;'

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon


# Disable the bell
#if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Set the default editor to vim.
export EDITOR=vim


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

#######################
# COMPLETITION
#######################






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

PS1="${OFF}"
PS1+="\[\e[30;1m\](\D{%Y.%m.%d} \t\[\e[30;1m\])"
PS1+=""
PS1+="\[\e[30;1m\](\[\e[36;1m\]CPU:$(__cpu)%" # CPU
PS1+="\[${DARKGRAY}\]|\[${MAGENTA}\]Jobs:\j" #Jobs
PS1+="\[${DARKGRAY}\]|\[${MAGENTA}\]Net:$(cat /proc/net/tcp | wc -l)"  # Network Connections
PS1+="\[${DARKGRAY}\]|\[${MAGENTA}\]Users:$( who | wc -l)"
PS1+="\[\e[30;1m\])"
PS1+="\[\e[30;1m\](\[\e[32;1m\]\$(df -h / | tail -1 | awk 'END {print \"Root:\" \$3 \"/\" \$2}')"
PS1+="\[\e[30;1m\]"
PS1+=")(\[\e[32;1m\]\$(ls -ld */ 2>/dev/null | wc -l) dir, \$(find . -maxdepth 1 -type f 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"
#PS1+=")(\[\e[32;1m\]\$(find . -maxdepth 1 -t d 2>/dev/null | wc -l) dir, \$(/bin/ls -1 2>/dev/null| /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\]) \n"

## {USER@HOST:/PATH}
PS1+=" ${DARKGRAY}{"
PS1+="${USERNAME}"
PS1+="${LIGHTCYAN}@${LIGHTGREEN}$HOST"
PS1+="${PURPLE}$MULTNAME" # Append screen name if in a screen
PS1+="${LIGHTBLUE}:$DIR" #PATH
PS1+="${DARKGRAY}} ${PROMPTSYMBOL} "
PS1+="${OFF}"

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



































