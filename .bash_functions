###############################################################################
# This is GPL 3.0 so if you copy from here, be sure to make yours available
# Any suggestions welcomed !
# 
# Functions will start with a double underscore __ 
# An alias will then map the function to a good name
# That is so it's easier to search alias and easier to read/understand
###############################################################################

###############################################################################
# HELPER FUNCTIONS 
###############################################################################

#######################################
# VARIABLES
#######################################

__hasspace(){ 
case "$1" in  
     *\ * )
           #echo "match"
           return 1
          ;;
       *)
           #echo "no match"
           return 0
           ;;
esac
} # https://stackoverflow.com/questions/1473981/how-to-check-if-a-string-has-spaces-in-bash-shell

#######################################
# PIPES
#######################################

function __fawk { #get a certain column of the output, as in df -h | awk '{print $2}' = df -h|fawk 2
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
} 

###############################################################################
# FUNCTIONS FOR ALIASES                                               
###############################################################################

#######################################
# BACKUP
#######################################

# FIXME still working ???

GITDOTBKUSER="johnr14"

__gitdotbk_help(){
echo "     gitdotbk commit -am 'Description' #  commit your changes"
echo "     gitdotbk bk #  commit your changes and push to github if configured"
echo "     gitdotbk ls-tree -r master --name-only # list files tracked"
echo ""
echo "     gitdotbk-github # setup origin to your personal github"
echo "     gitdotbk push -u origin master # Push to your github"
echo "  Note : to github, you must specify a '$GITDOTBKUSER' in .bash_mymy_private"
echo "         and create an empty github repository named mymy-bash"
echo ""
}

__gitdotbk(){ # Backup dot files to ~/.dotcfgbk
if ! [ -d "$HOME/.gitdotbk" ]; then
    echo "There don't seems to ba a ~/.dotcfgbk directory already."
    echo "Would you like to initialise it and start using gitdotbk ?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) __setgitdotbk; break;;
            No ) return;;
        esac
    done
    if ! [ -d "$HOME/.gitdotbk" ]; then
        echo "There was an error and directory not initialised"
        return -1
    fi

    echo "Now that you have gitdotbk initialised, you can :"
    __gitdotbk_help
else
    if [ "$#" -eq 1 ]; then
        echo "Your ~/.dotcfg is already configured. Use the following commands :"
        __gitdotbk_help
    elif [[ ( "$#" -eq 2 && "$1" == "bk") ]]; then
        echo "Commiting to local repository"
        __gitdotbk_cmd commit -am 'Backup of dotfiles'
        $REMOTEEXIST=$(__gitdotbk_cmd show-branch *master | grep "refs/remotes/")
        if ! [ -n "$REMOTEEXIST" ]; then
            echo "Commiting to github"
            __gitdotbk_cmd push -u origin master # TODO branching depending of computer name
        fi
    else
    __gitdotbk_cmd $@
    fi
fi
}

__gitdotbk_githubinit() { # Initialise your remote github
$REMOTEEXIST=$(__gitdotbk_cmd show-branch "*master" | grep "refs/remotes/")
if ! [ -n "$REMOTEEXIST" ]; then
    echo "You don't have initialised a remote github master, would you like to do it ?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) __gitdotbk_githubremoteinit; break;;
            No ) return;;
        esac
    done
fi

}

__gitdotbk_githubremoteinit() {
# Load or reload private definitions
if [ -f ~/.bash_mymy_private ]; then
    . ~/.bash_mymy_private
fi

if ! [ -n "$GITDOTBKUSER" ]; then
    echo "Username '$GITDOTBKUSER' not definet in .bash_mymy_private"
    echo "You must configure it before continuing."
    return -1
fi
echo "Using user $GITDOTBKUSER for github."
echo "For it to work, you must have created a mymy-bash in your github" 
__gitdotbk_cmd remote add origin https://github.com/$GITDOTBKUSER/mymy-bash.git
echo "If you created a README.md in your new git you have to run :" 
echo "__gitdotbk_cmd pull origin master --allow-unrelated-histories -f"
#FIXME send to a new branch
__gitdotbk_cmd push -u origin master
}

__gitdotbk_cmd () { # Helper function
git --git-dir=$HOME/.gitdotbk/ --work-tree=$HOME "$@"
} 

__setgitdotbk() {
if [ -d "~/.gitdotbk" ]; then
    echo "There seems to ba a ~/.gitdobk directory already. Abording"
    return -1
fi
touch README.md
touch LICENSE
git init --bare ~/.gitdotbk
__gitdotbk_cmd config --local status.showUntrackedFiles no
__gitdotbk_cmd add $HOME/.bash_aliases
__gitdotbk_cmd add $HOME/.bash_completition
__gitdotbk_cmd add $HOME/.bashrc
__gitdotbk_cmd add $HOME/.profile
__gitdotbk_cmd add $HOME/.screenrc
__gitdotbk_cmd add $HOME/.vimrc
__gitdotbk_cmd add $HOME/README.md
__gitdotbk_cmd add $HOME/LICENSE
__gitdotbk_cmd commit -am 'Initial commit of dotfile'
} # https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

#######################################
# BASH RELATED
#######################################
__aliassearch() { # Search for alias by keyword

#FIXME BUG IF THERE IS A : IN COMMENTS

LIGHTBLUECODE='\e[1;34m'
LIGHTGREENCODE='\e[1;32m'
# cat .bash_aliases | grep '^alias' | grep -E '#' | cat .bash_aliases | grep '^alias' | cut -d' ' -f2- | grep -E '#' | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sed 's/^/\$(printf $LIGHTBLUE)/; s/ /\$(printf $LIGHTGREEN) /'  | sort | column -t -s: | grep 
#alias alias-search="cat .bash_aliases | grep '^alias' | grep -E '#' | cat .bash_aliases | grep '^alias' | cut -d' ' -f2- | grep -E '#' | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sed 's/^/\$(printf $LIGHTBLUE)/; s/ /\$(printf $LIGHTGREEN)\t /'  | sort | column -t -s '\t' " # alias - Show all aliases TODO
cat $HOME/.bash_aliases | grep "^alias" | sort | grep "$1" | sed -r 's/\s+/ /' | sed 's/=.*#/ \t: #/' | sed 's/^alias //'  | sed "s/^/$(printf $LIGHTBLUECODE)/; s/ /$(printf $LIGHTGREENCODE) /" | sort | column -t -s:
}

#https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c
# Automatically install the needed support files for this .bashrc file
install_bashrc_support ()
{
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		sudo yum install multitail tree joe
	elif [ $dtype == "suse" ]; then
		sudo zypper install multitail
		sudo zypper install tree
		sudo zypper install joe
	elif [ $dtype == "debian" ]; then
		sudo apt-get install multitail tree joe
	elif [ $dtype == "gentoo" ]; then
		sudo emerge multitail
		sudo emerge tree
		sudo emerge joe
	elif [ $dtype == "mandriva" ]; then
		sudo urpmi multitail
		sudo urpmi tree
		sudo urpmi joe
	elif [ $dtype == "slackware" ]; then
		echo "No install support for Slackware"
	else
		echo "Unknown distribution"
	fi
}

function __printfright()
{ # https://stackoverflow.com/questions/5506176/bash-echo-something-to-right-end-of-window-right-aligned

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

col=80 # change this to whatever column you want the output to start at

if TRUE; then
  printf '%s%*s%s' "$GREEN" $col "[OK]" "$NORMAL"
else
  printf '%s%*s%s' "$RED" $col "[FAIL]" "$NORMAL"
fi
# https://unix.stackexchange.com/questions/396223/bash-shell-script-output-alignment

}

function __history1 ()
{
history 1 | sed 's/^ *[0-9]* *//'
}

function __hh ()
{ #https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# FIXME WIP STOPPED HERE
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -p|--path)
        HH_PATH="$2"
        shift # past argument
        shift # past value
        ;;
        -t|--terminal)
        HH_TERM="$2"
        shift # past argument
        shift # past value
        ;;
        -c|--computer)
        HH_COMPUTER="$2"
        shift # past argument
        shift # past value
        ;;
        -l|--list)
        echo "Possible terminals :"
        cat $HOME/.bash_history-merged | awk -vFPAT='("[^"]+")' '{print $2}' | sort | uniq
        echo "Possible computers :"
        cat $HOME/.bash_history-merged | awk -vFPAT='("[^"]+")' '{print $3}' | sort | uniq
        return
        ;;
        -h|--help)
        echo "
        
Search $HOME/.bash_history-merged
    -p|--path       matching path of pwd
    -t|--terminal   match terninal name
    -c|--computer   match computer name
    -l|--list       list terminal names and computer names
    -h|--help       this help
        "
        shift # past argument
        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -n $1 ]]; then
    cat $HOME/.bash_history-merged | grep $1
else
    tail -n 15 $HOME/.bash_history-merged 
fi

#cat .bash_history-merged | awk -vFPAT='("[^"]+")' '$2 == "\"pts=12\"" {print $0}'

}

# Print history of where commands where executed
__hhpwd() {
    cat $HOME/.bash_history-merged | awk '{print $4}' | uniq | sed 's/\"//g'
}

#######################################
# CHECKSUM SHA AND MD5
#######################################
#FIXME MORE !

__md5check() { md5sum "$1" | grep "$2";} #md5check [file] [key] #FIXME

#######################################
# COMPRESSION AND DECOMPRESSION
#######################################

#TODO LIST & EXTRACT ##DAR,ZPAQ,XZ ??
#FIXME CHECK THAT IT CREATES A DIRECTORY ? or parse -d 
__ex () { # Extract compressed file
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "'$1': unrecognized file compression" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

#######################################
#  ENERGY
#######################################

__apcwatt() { # Return watts used on APC connected UPS
LOADPCT=`apcaccess  | grep 'LOADPCT' | awk '{ print $3 }'`
NOMPOWER=`apcaccess  | grep 'NOMPOWER' | awk '{ print $3 }'`
WATT=$((${LOADPCT%.*}*$NOMPOWER/100))
echo "$WATT"
}

#######################################
#  FILES AND DIRECTORIES
#######################################


__cdls() { # perform 'ls' after 'cd' if successful.
  builtin cd "$*"
  RESULT=$?
  if [ "$RESULT" -eq 0 ]; then
    ls
  fi
}

__copy() { # Copy file with a progress bar
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

__fgrept() { # Searches for text in all files in the current folder recursively
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
grep -iIHrn --color=always "$1" .
}

__mkcd() { #mkdir and cd combined
if [ -z $1 ]; then
    echo -e \e[0;31;1mUsage: mkcd [directory]\e[m;
else
    if [ -d $1 ]; then
        echo Changed to $1.;
        cd $1;
    else
        mkdir $1;   
        echo Created $1;
        cd $1;
    fi;
fi
}

function show_empty_folders {
    find . -depth -type d -empty
} # https://gist.github.com/torifat/1254570


#######################################
# NETWORKING RELATED
#######################################

__netinfo() { # Show current network information
    if [ -n "$1" ]; then
        echo "$(ifconfig "$1" 2>/dev/null | grep "inet ")$(ifconfig "$1" 2>/dev/null | grep "ether ")"
    else
        #echo "$(ifconfig 2>/dev/null | grep "flags=" | awk '{print $1}' )$(ifconfig 2>/dev/null | grep "inet " | sed -e 's/  */ /g' )$(ifconfig 2>/dev/null | grep "ether " | sed -e 's/  */ /g')" 
        IFACES=$(ifconfig 2>/dev/null | grep "flags=" | tr ':' ' '| awk '{print $1}')
        for IFACE in $IFACES
        do
            VALIDIP=$(ifconfig $IFACE | grep -E "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
            if [ -n "$VALIDIP" ]; then
                ifconfig $IFACE 2>/dev/null | grep -E "flags=|inet" | tr '\n' ' ' | sed -e 's/  */ /g' | sed 's/flags=.*inet //; s/prefixlen.*//' | awk '{print $0}'
            else
                echo "$IFACE: has no IPV4 configured"
            fi
        done
    fi
}

__whatsmyip () { # IP address lookup
	# /sbin/ifconfig |grep -B1 "inet " |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';
	# Internal IP Lookup
	echo -n "Internal IP: " ; ifconfig $(route | grep default | awk '{ print $8 }') 2>/dev/null | grep "inet " | awk '{print $2}' 
	# External IP Lookup
	echo -n "External IP: " ; curl -s ifconfig.co 2> /dev/null
}

#######################################
# PARSING PIPES 
#######################################

__lessl () { #Scroll to line number
if [[ $# == 0 ]]; then
    command less -i -x4 -;
    return;
fi;
local num=$(sed -n 's,^.*:([0-9]*)$,1,p' <<< "$1");
local file="${1%:$num}";
shift;
if [[ -n $num ]]; then
    command less -i -x4 +${num}g "$file" "$@";
else
    command less -i -x4 "$file" "$@";
fi
} # Forgot source


function __pawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}


#######################################
# PROCESS RELATED
#######################################

__pskill() { #kill a process by name
if [ -z $1 ]; then
    echo -e \e[0;31;1mUsage: pskill [processName]\e[m;
else
    ps -au $USER | grep -i $1 |awk {print kill -9 $1}|sh
fi
}



#######################################
# SCREEN, TMUX & SSH RELATED
#######################################

__isscreen(){ # Check if running from a screen
if [ "$(ps -o comm= -p $PPID)" == "screen" ]; then 
    echo "Running from screen $(CURSCREENPID=$(ps -o pid -p $PPID | tail -n1); screen -ls | grep $CURSCREENPID | awk '{ print $1 }')"
    return 1
else 
    echo "Not running in a screen"
    return 0
fi
}

__isssh(){ # Check if session is in a ssh #FIXME RECURSIVE CHECK
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      echo "In a ssh connection from $(echo "$SSH_CLIENT" | awk '{ print $1 }') on $SSH_TTY"
else
  case $(ps -o comm= -p $PPID) in 
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi
}

__screenlaunch() {  # Start a new screen and start application before detaching it
screen -d -m $1
}

__screenc() { #Connect to screen #n and detatching it if already attatched
	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		echo "Must provide a number"
		return 0
	elif [[ "$1" -gt "$(screen -ls | head -n -1 | tail -n +2 | wc -l)" ]]; then
		echo "Number exceed available screens"
		return 0
	fi
        screen -R -d $(screen -ls | head -n -1 | tail -n +2 | sed -n "$1p" | awk '{ print $1 }')
}

__screenrename() { # Rename screen session name, accept: screen# | screensession
if [ -n "$2" ]; then
    HASSPACE='__hasspace "$2"'
    if [ -z "$HASSPACE" ] ; then
        echo "Name can't contain space"
        return -1
    fi
fi
NBSCR=$(screen -ls | head -n -1 | tail -n +2 | wc -l)
if  [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -le "$NBSCR" ]; then
    if [ -n "$2" ]; then
        screen -S $(screen -ls | head -n -1 | tail -n +2 | sed -n "$1p" | awk '{ print $1 }') -X sessionname $2
        if [ "$?" -eq 0 ]; then
            echo "Renamed screen #$1 to $2"
            return 0
        else
            echo "Could not rename screen $1 to $2"
            return -1
        fi
    else 
        echo "You must provide a new screen name"
        exit 1
    fi
elif [ -n "$2" ]; then
    #check if screen name exist
    SCEXIST=`screen -ls | head -n -1 | tail -n +2 | awk '{ print $1 }' | grep "^$1\$"`
    if [ "$SCEXIST" ]; then
        screen -S $1 -X sessionname $2
        if [ "$?" -eq 0 ]; then
            echo "Renamed screen $1 to $2"
            return 0
        else
            echo "Could not rename screen $1 to $2"
            return -1
        fi
    else
        echo "Screen name provided is not a screen"
        return -1
    fi
elif [ -n "$1" ] && [ -z "$2" ]; then
    CURSCREENNAME=$(CURSCREENPID=$(ps -o pid -p $PPID | tail -n1); screen -ls | grep $CURSCREENPID | awk '{ print $1 }')
    screen -S $CURSCREENNAME -X sessionname $1
    if [ "$?" -eq 0 ]; then
        echo "Renamed curent screen \"$CURSCREENNAME\" to $2"
        return 0
    else
        echo "Could not rename screen \"$CURSCREENNAME\" to $2"
        return -1
    fi
    exit 0
else
    echo "You must provide a PID.screenname or screen# (not pid) from screen -ls"
    exit -1
fi
}


__scw() { #Find what screens are doing
#FIXME
echo "NOT IMPLEMENTED"
}
#https://unix.stackexchange.com/questions/153808/find-out-which-command-is-running-within-a-screen-session

#######################################
# RANDOM RELATED
#######################################

__randpassgen() { < /dev/urandom tr -dc A-Za-z0-9_ | head -c$1 ; echo; }


###############################################################################
# HELP FUNCTION                                                   
###############################################################################

# FILES
# .bashrc
# .bash_alias
# .bash_functions
# .bash_mymy_sshhosts
# .bash_mymy_mounts
# .bash_history


###############################################################
# FUNCTIONS                                                   #
###############################################################


lessl () #Scroll to line
{
if [[ $# == 0 ]]; then
command less -i -x4 -;
return;
fi;
local num=$(sed -n 's,^.*:([0-9]*)$,1,p' <<< "$1");
local file="${1%:$num}";
shift;
if [[ -n $num ]]; then
command less -i -x4 +${num}g "$file" "$@";
else
command less -i -x4 "$file" "$@";
fi
}


#kill a process by name
pskill()
{
if [ -z $1 ]; then
echo -e \e[0;31;1mUsage: pskill [processName]\e[m;
else
ps -au $USER | grep -i $1 |awk {print kill -9 $1}|sh
fi
}

#mkdir and cd combined
mkcd()
{
if [ -z $1 ]; then
echo -e \e[0;31;1mUsage: mkcd [directory]\e[m;
else
if [ -d $1 ]; then
 echo Changed to $1.;
 cd $1;
else
 mkdir $1;
 echo Created $1;
 cd $1;
fi;
fi
}

# perform 'ls' after 'cd' if successful.
cdls() {
  builtin cd "$*"
  RESULT=$?
  if [ "$RESULT" -eq 0 ]; then
    ls
  fi
}

#TODO
#LIST & EXTRACT ##DAR,ZPAQ,XZ ??

ex () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "'$1': unrecognized file compression" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}




#TO FIX
#https://www.idnt.net/en-GB/kb/941772
#
#alias __cpu="grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage}' | awk '{printf(\"%.01f\n\", \$1)}'"
function __cpu ()
{

SYSLOAD=$(uptime|awk '{ print $(NF-2) } ' | sed 's/,//')
NPROC=$(nproc)
bc -l <<< $SYSLOAD/$NPROC

}

# Copy file with a progress bar
#copy()
#{
#	set -e
#	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
#	| awk '{
#	count += $NF
#	if (count % 10 == 0) {
#		percent = count / total_size * 100
#		printf "%3d%% [", percent
#		for (i=0;i<=percent;i++)
#			printf "="
#			printf ">"
#			for (i=percent;i<100;i++)
#				printf " "
#				printf "]\r"
#			}
#		}
#	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
#}

# Show current network information
# NOT WORKING FIXME
#netinfo ()
#{
#	echo "--------------- Network Information ---------------"
	#ifconfig | awk /'inet addr/ {print $2}'
	#echo ""
	#ifconfig | awk /'Bcast/ {print $3}'
	#echo ""
	#ifconfig | awk /'inet addr/ {print $4}'

	#ifconfig | awk /'HWaddr/ {print $4,$5}'
	#echo "---------------------------------------------------"
#}

































