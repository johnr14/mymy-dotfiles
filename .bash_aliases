###############################################################################
# Alias 
#
# Notes :
# Double quotes " should be used if alias is to be searchable
# Comment must be added at the end of the alias for it to be searchable
# Naming convention
#   for comment : mainprg - helping description
#
# Sections are seperated with a number of '#' and are used to search the alias file
# 64 Major section
# 32 Minor section 
# 16 Minor sub-section
# 8  Tiny  sub-section
###############################################################################

###############################################################################
# This is GPL 3.0 
# Any suggestions welcomed !
# 
# There are quite a few TODO & FIXME
# - Make it more portable for other BSDs
# Once you have lots of alias, searching them with the command
# aliassearch KEYWORD will return matching results for alias
# ffnd KEYWORD will return matching results for functions
# afnd KEYWORD will return matching results for alias and functions
#   That's why comments are on the same line, to be easily parsed
#   And it's required that a # comment is on every alias for easy description
#
###############################################################################

######
## TODO

# Make sure that admin commands have sudo in them

######

#
# cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -v "#" | sed -e 's/\=.*\#/ =/'| sort
# cat .bash_aliases | grep "^alias" | grep -E "#" | cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -E "#" | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sort | column -t -s:
#

################################################################
# Colors & symbols
################################################################
# not searchable

BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
MAGENTA='\e[1;35m'
YELLOW='\e[1;33m'
LIGHTYELLOW='\e[0;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color

BOLD=$(tput bold)
NORMAL=$(tput sgr0)



#Symbols
LIGHTNING_BOLT="⚡"
      UP_ARROW="↑"
    DOWN_ARROW="↓"
      UD_ARROW="↕"
      FF_ARROW="→"
       RECYCLE="♺"
        MIDDOT="•"
     PLUSMINUS="±"

###############################################################
# Alias helper                                          
###############################################################


alias alias-less='cat $HOME/.bash_aliases | grep "^alias" | less -R' # Show alias
alias alias-less="less $HOME/.bash_aliases" # alias - Show all aliases
alias alias-reload="source ~/.bash_aliases"  # alias - Reload only aliases
alias alias-search='__aliassearch' # Search for alias by keyword
alias alias-viewcmd="" # alias - Show cmd for an alias
#cat .bash_aliases | grep "^alias" | sort

# TODO expand alias 



###############################################################
# BACKUP RELATED
###############################################################

#alias bkbash='__bkbash' # Backup bash configuration files

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

###############################################################
# Bash related                                           
###############################################################

###############################
# History                     
###############################
alias h="history | grep -i"
alias mostused="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -15" # History - most used cmd FIXME

#alias hs='history | grep -i ' # 
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr" # history - shows most  FIXME


if [ -f $HOME/.bash_history-merged ]; then
alias hh="__hh" # history - return last 15 cmd run; can also pass argument to grep output
alias hhpwd="__hhpwd" # hhpwd - return last directories where commands where run
fi
#######################################
# COLORIZE
#######################################

# Install  colordiff package :)
alias diff='colordiff' # Colorized diff

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto -i'   # Colorized grep
alias egrep='egrep --color=auto -i' # Colorized egrep
alias fgrep='fgrep --color=auto -i' # Colorized fgrep



###############################
# Misc                        
###############################

#FIXME BETTER CLASSIFICATION PLS

alias beep='echo -en "\007"' # Beep
alias chkcmd="type -t" # Check to see if a command is aliased, a file, or a built-in command
alias colorslist="set | egrep 'COLOR_\w*'" # Lists all the used colors
alias exit='clear; exit'
alias lspath='echo -e ${PATH//:/\\n}' # List paths in $PATH
alias reload='source $HOME/.bashrc'     # Reload bashrc 
alias less='less -R'

alias allttys="ps a | grep -vi 'tty*' " # ps - list all opened tty
alias ttyc="tty | sed -e 's/\/dev\/\(pts\|tty\)\///' | sed -e 's/\/dev\///'" # tty - get current tty number, works in direct terminal or ssh


# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

#Screen related
alias c='clear' # Clear the screen
alias cla='clear; la' # Clear screen and list all
alias cld='clear; lsd' # Clear screen and list directories
alias cls='clear; ls' # Clear screen and list

#Terminal related
alias fix='echo -e "\033c"' # Fix terminal when weird caracters replaced prompt; after cat a binary file

###############################################################
# CHECKSUM SHA, MD5 & RANDOM
###############################################################

#FIXME pipe data?
alias opensslsha1="openssl dgst -sha1" # openssl dgst -sha1
alias opensslsha2="openssl dgst -sha256" # openssl dgst -sha256
alias opensslsha512="openssl dgst -sha512" # openssl dgst -sha512
alias opensslb64="openssl enc -base64" # openssl enc -base64

alias md5check="__md5check" # md5sum - pass [file] [key] and will return matching if identical

#######################################
# RANDOM RELATED
######################################
alias randpass8='__randpassgen 8' # Generate a random password of size 8
alias randpass16='__randpassgen 16' # Generate a random password of size 16
alias randpass32='__randpassgen 32' # Generate a random password of size 32
alias randpass64='__randpassgen 64' # Generate a random password of size 64

# FIXME
randpassgen() { < /dev/urandom tr -dc A-Za-z0-9_ | head -c$1 ; echo; }

###############################################################
# CODING RELATED
###############################################################

#Compilling FIXME more optimisation fox avx ?
alias compc="gcc -o exe -O3 -lm -W -Wall -Wuninitialized -fbounds-check "

#Git #FIXME probably more complete/useful versions?
alias gs='git status' # Git status
alias ga='git add' # Git add
alias gc='git commit -am' # Git commit
alias gu='git up' # Git up
alias gp='git push' # Git push
alias gd='git diff' # Git diff 
alias gb='git branch' # Git branch
alias gup='gu && gp' # Git up and git push
alias gcup='gc && gup' # Git commit and git up and push

alias gitlog-resumed="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # git - git log overview of commits for a file 
alias gitlog-view="git log --follow -p -- " # git - view all changes from commits on a file
#alias gitrevert="git revert"
# alias gitshow="" 

###############################################################
# COMPRESSION AND DECOMPRESSION
###############################################################

# Compressed files
alias ex='__ex' # Extract compressed file by matching extension

###############################################################
# DESKTOP RELATED
###############################################################
# FIXME
# valid .Xauthority
#GUI RELATED
# Allow local users to use my X session
# xhost +local:

# xterm
# alias xterm='xterm -bg black -fg green'

###############################################################
# FILES AND DIRECTORIES
###############################################################

# Bash Directory Bookmarks http://www.huyng.com/posts/quick-bash-tip-directory-bookmarks/
alias m1='alias g1="cd `pwd`"' # Bookmark curent directorie to g1
alias m2='alias g2="cd `pwd`"' # Bookmark curent directorie to g2
alias m3='alias g3="cd `pwd`"' # Bookmark curent directorie to g3
alias m4='alias g4="cd `pwd`"' # Bookmark curent directorie to g4
alias m5='alias g5="cd `pwd`"' # Bookmark curent directorie to g5
alias m6='alias g6="cd `pwd`"' # Bookmark curent directorie to g6
alias m7='alias g7="cd `pwd`"' # Bookmark curent directorie to g7
alias m8='alias g8="cd `pwd`"' # Bookmark curent directorie to g8
alias m9='alias g9="cd `pwd`"' # Bookmark curent directorie to g9
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bash_ohmy_bookmarks'   # Save bookmarked directories alias (g1-g9) FIXME
alias mls='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"' # List directories bookmark alias (g1-g9)
touch ~/.bash_mymy_bookmarks && source ~/.bash_mymy_bookmarks

# Chmod files #FIXME more modes?
alias ax="chmod --preserve-root a+x" # make executable
alias or="chmod --preserve-root o+r" # make readable by all
alias ux="chmod --preserve-root u+x" # make user executable
alias 000='chmod --preserve-root -R 000' # TODO
alias 644='chmod --preserve-root -R 644' # TODO
alias 666='chmod --preserve-root -R 666' # TODO
alias 755='chmod --preserve-root -R 755' # TODO
alias 777='chmod --preserve-root -R 777' # TODO

# Counting
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null" # Count all files (recursively) in the current folder
alias dirsize="du -shx * .[a-zA-Z0-9_]* 2> /dev/null"

# Directories
alias cdls='__cdls' # perform 'ls' after 'cd' if successful.
alias mkcd='__mkcd' # mkdir and cd combined
alias ..="cd .." # cd ..
alias ...="cd ../.." # cd ../..
alias ....="cd ../../.." # cd ../../..
alias .....="cd ../../../.." # cd ../../../..

#https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c
alias folders='du -h --max-depth=1' # Show directories size
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn' # Show directories size ordered by size
alias tree='tree -CAhF --dirsfirst' # Show recursive structure with file
alias treed='tree -CAFd' # Show recursive directory structure

# Find files
alias ff="find . -name " # Find file by name
alias bigfiles='find -type f -printf "%s %p\n" . | sort -nr | head -n 40 | numfmt --field=1 --to=iec-i' # Find biggest 40 files recursively with size

# Listing files and directories
alias ll='ls -F --color --time-style="+%d %b %Y %H:%M"' # List long
alias ls='ls -lacf --color' # List files in colors
alias lls='ls -lacF' # List files in colors, directories end with /
alias la="ls --color -lAGbhF --time-style='+%d %b %Y %H:%M'  --group-directories-first" # List all
alias lx="ls --color -lGbhFXB --time-style='+%d %b %Y %H:%M' | grep -v /" # List files by extensions
alias lf="ls --color -lGbhF --time-style='+%d %b %Y %H:%M' | grep -v /" # List files by filename
alias lsd="ls -ld --color -tolAGbhF --time-style='+%d %b %Y %H:%M' */" # List directories only
alias llt="ls -thor --time-style='+%d %b %Y %H:%M' | head " # List most recent file changed
alias llta="ls -thor --time-style='+%d %b %Y %H:%M'" # List files ordered with most recent on top

# Listing files sorted
alias lsx='ls -lXBh' # ls - sort by extension
alias lsk='ls -lSrh' # ls - sort by size
alias lsc='ls -lcrh' # ls - sort by change time
alias lsu='ls -lurh' # ls - sort by access time
alias lst='ls -ltrh' # ls - sort by date

# Remove empty directories
alias rmdirempty='find . -type d -empty -delete' # find - remove all empty directories recursively

# Count all files (recursively) in the current folder



###############################################################
# LANGUAGE
###############################################################

#MORE ??
alias orthographe="aspell -t check --lang=fr "
alias spellcheck="aspell -t check --lang=en "

###############################################################
# MOUNTS AND SPACE
###############################################################

alias dfc='dfc -W -d -s -T -t ext2,ext3,ext4,zfs,btrfs,fuseblk,fuse,ntfs,fat,xfs,nfs 2>/dev/null' # Show colorized mounts of real filesystems with bars
alias mounts="mount | grep -v 'cgroup\|sysfs\|tmpfs\|proc\|debugfs\|securityfs\|devpts\|mqueue\|pstore\|hugetlbfs'" # mount - show real mounts only

#SSH MOUNTS
#alias sshmounts=


###############################################################
# MOVING FILES AND DIRECTORIES 
###############################################################

alias copy='__copy()' # Copy file with a progress bar

###############################################################
# Multimedia
###############################################################

###################
# audio
###################

# Cd backup
# convert to opus, mp3, ogg, flac, wav
# Extract audio from video

###################
# ffmpeg & video
###################
# Codec comparison
# https://www.texpion.com/2018/07/av1-vs-vp9-vs-avc-h264-vs-hevc-h265-2-psnr.html
# x264 for faster speed / quality / size ratio
# AV1 for smaller file, slow, not fully matured and supported currently, but will be a standard soon; will be faster with the work on SVT-AV1
# x265 for best quality 




# DVD/Bluray backup
# Convert to webm, av1, x264, x265
# Rotate
# Cut
# Smooth
# ffmpeg -t 20 -i 05410004.MOV -vf vidstabdetect=stepsize=32:mincontrast=0.001:shakiness=10:accuracy=15:result=transform_vectors.trf -f null -
# ffmpeg -i 05410004.MOV -vf vidstabtransform=input=transform_vectors.trf:zoom=.0005:smoothing=340:maxshift=64:maxangle=0.7,unsharp=5:5:0.8:3:3:0.4 -vcodec libx264 -preset slow -tune film -crf 18 -an 05410004.maxangle07.mp4

# Resize
# Reframe
# Extract meta


###################
# imagemagick and image
###################

# Generate video 
# Animate to gif (from img or video)
# Strip meta
# Max compression of image

###################
# Upload audio/image/video 
###################

# To youtube or youphptube
# 

###################
# youtube-dl
###################

# Extract audio & add thumbnail
# Download video & thumbnail
# Convert to format


###############################################################
# NETWORKING
###############################################################

alias ping='ping -c 5 ' # ping -c 5

#Debug http
debug_http () { curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; } # WARN:TOCHECK debug_http: download a web page and show info on what took time
http_headers () { curl -I -L $@ ; } # WARN:TOCHECK http_headers: get just the HTTP headers from a web page (and its redirects)

#Downloading
alias wget='wget -c' # wget -c for resuming
alias wgetlist="wget -ca -e robots=off --no-parent --recursive --mirror -p --convert-links --wait=5 -A html --cut-dirs=1 --user-agent=Mozilla/5.0 -P wgets/ -i  " # WARN:TOCHECK Parse $1 file as http files to download and save to wgets directory 


###############################################################
# PARSING PIPES 
###############################################################
alias lessl='__lessl' # less - scroll to line number #
alias pawk="__pawk" # awk - get a certain column of the output, as in awk '{print $2}' = |pawk 2

###############################################################
# PROCESS RELATED
###############################################################

#TODO More jobs
alias j='jobs -l' # Current running jobs

alias p="ps aux | grep " # ps aux | grep 
alias psn='ps aux | tail -n +2 | wc -l' # Total number of processes running
alias psu='ps -fHU $USER' # ps for current user

alias pskill='__pskill' # Kill a process by name

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# to find memory hogs:
alias mem_hogs_top='top -l 1 -o rsize -n 10'
alias mem_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10' # to find CPU hogs

alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"


#TODO NICE

###############################################################
# SCREEN, SSH, terminal & TMUX RELATED
###############################################################

###############################
# SCREEN            
###############################

alias screens='screen -list' # List screen
alias screenconnect='__screenconnect' # Connect to screen #n or PID.NAME
alias screenrename='__screenrename' # Rename screen session name, accept: [screen# | screensession | empty ] newname

#alias screenlaunch='__screenlaunch' # Start a new screen and start application
#alias screenlaunchdetach='__screenlaunchd' # Start a new screen, start application and detatch

# Am I running on a screen, ssh or tmux session ?
alias isscreen='__issc' # screen - check if running from a screen
alias isssh='__isssh' # ssh - check if curently in a ssh session



#TODO
# alias istmux='__istmux' # Check if currently running in a tmux session
# alias iswhat # Draw tree of parent process

#alias scw='__scw' # Find what screens are doing
#alias tmuxw='__tmuxw' # Find what tmux are doing

# Where do I have active ssh connections to 
# alias sshwhere='__sshwhere' # Where do I have active ssh connections
# alias sshwhat='__sshwhat' # What is running on my ssh connections

#ps u -p $(ps -el | grep $(ps -el | grep SCREEN_SESSION_PID | grep bash | awk '{print $4}') | grep -v bash | awk '{print $4}')

###############################
# SCREEN            
###############################
#SSH 
alias sshfromwhere="echo $SSH_CLIENT | awk '{ print $1 }'" # Find client originating ip on remote host

# ssh known hosts
# alias sshhistory="history | grep ssh | grep -E '[a-zA-Z0-9.-]@[a-zA-Z0-9.-]'"

###############################
# TERMINAL           
###############################
alias termname="ps -o comm= -p \$(xprop -notype -id \"$WINDOWID\" 32i '=\$0' _NET_WM_PID | sed 's/^.*=//')"
###############################
# TMUX            
###############################

# If tmux is not accessible, line in a sudo, you may get errors trying to parse those aliases
if [ -n "$TMUX" ]; then

alias tmuxcolors="for i in {0..255}; do     printf \"\x1b[38;5;${i}mcolour${i}\x1b[0m\n\"; done | column" # print - print table of all tmux colors

#######################
# Get information
#######################

#  tmux display -t yakuake:2.1 -p '#{pane_width}-#{pane_height}'


###############
# Session
###############
# Get info
alias tmuxcs="tmux display-message -p '#S'" # tmux - current session name
alias tmuxls="tmux ls" # tmux - list all sessions with info
alias tmuxlsn="tmux ls | awk '{ print \$1 }' | sed 's/://'" # tmux - list all session names
# Set
alias tmuxrs="tmux rename-session -t $(tmux display-message -p '#S') " # tmux - rename current session

###############
# Window 
###############
alias tmuxgw="" # tmux - get current window TODO

alias tmuxcw="tmux display-message -p '#W'" # tmux - display current window name
alias tmuxlw="tmux list-windows -a" # tmux - list windows for all sessions
alias tmuxlcw="tmux list-windows" # tmux - list current sessions windows

alias tmuxrw="tmux rename-window -t $(tmux display-message -p '#I') " # tmux - rename current window

#alias tmuxfaw="" # tmux - find active window of a session


###############
# Pane
###############

alias tmuxlcp="tmux list-panes -s -F '#{session_name}:#{window_name}.#{pane_title}' -t $(tmux display-message -p '#S')" # tmux - list panes and windows in current session
alias tmuxlp="tmux list-panes -s -F '#{session_name}:#{window_name}.#{pane_title}' -a" # tmux - list panes and windows in all sessions
alias tmuxcp="tmux display -pt "${TMUX_PANE:?}" '#{pane_title}'" # tmux - current pane name
alias tmuxcpa="tmux display -pt "${TMUX_PANE:?}" '#{session_name}:#{window_name}.#{pane_title}'" # tmux - current session.window:pane names

alias tmuxlpi="tmux list-panes -s -F '#{session_name}:#{window_name}.#{pane_title} [#{pane_width}x#{pane_height}]' -a" # tmux - list pane information : pane size

alias tmuxlpp="" # tmux - list pannels paths TODO

#alias tmuxsm="" # tmux - send message to active window of session TODO


alias tmuxrp="tmux select-pane -t $(tmux display -pt ${TMUX_PANE:?} '#{pane_index}') -T " # tmux - rename current panel
alias tmuxresizeto="" # tmux - resize pane to size

#######################
# Set configuration
#######################

# tmux display -pt "${TMUX_PANE:?}" '#{pane_index}' # tmux - list sessions.windows.panes
# I=$(tmux list-panes -a | grep $TMUX_PANE 2>/dev/null | awk -F: '{print $2}' | awk -F. '{print $2}') # Get current pane number

###############
#Rename
###############





###############
# Terminals
###############

alias tmuxlt="tmux list-panes -a -F '#{pane_tty} #{session_name}'" # tmux - list all terminals attatched to tmux server

###############
#Create
###############

###############
#Close/kill
###############
alias tmuxk="tmux kill-session -t " # tmux - kill session name

#https://gist.github.com/MohamedAlaa/2961058
alias tmuxkillall="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill" # tmux - kill all your tmux sessions !

###############
#Connect
###############


# TODO
#tmux list sessions and prompt selection

# TMUX DEFAULT CONF WINDOWS
# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened



fi # End $TMUX if




#######################################
# SEARCH AND FIND
######################################

alias fgrept='__fgrept' # Searches for text in all files in the current folder recursively

###############################################################################
# SYS ADMIN RELATED 
###############################################################################


#######################################
# CONTAINERS AND VMs
#######################################

#TODO

#Docker
#LXC
#Proxmox
#QEMU
#VIRTUALBOX
#VMWARE

#######################################
# MONITORING
#######################################

alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f" # Tail all logs
alias syslog='sudo tail -100f /var/log/syslog' # View last and tail syslog 
alias messages='sudo tail -100f /var/log/messages' # View last and tail log messages

alias allcron='for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; done' # List all crontab jobs for all users, in sudo !

alias gtop='/usr/bin/gnome-system-monitor &' # gnome-system-monitor - launch the application



###################
# CPU
###################

alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10' # Find top 10 CPU hogs
alias pscpu='ps auxf | sort -nr -k 3' # Get top process eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10' # Get top 10 process eating cpu
alias topcpu="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10" # Show top 10 cpu intensive process

###################
# DISK
###################

alias diskwho='sudo iotop' # Show processes reading/writing to disk #TODO BETTER !


###################
# ENERGY
###################

alias bat_status='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep  -E "state|to\ full|percentage|time to empty"' # WARN:TOCHECK Status FIXME CHECK IF WORKING

#######
# APC 
#######
alias apcwatt="__apcwatt" # Return watts used on APC connected UPS
alias apcleft="apcaccess | grep 'TIMELEFT' | awk '{ print $3 }'" # APC UPS time left on battery
alias apccharge="apcaccess | grep 'BCHARGE' | awk '{ print $3 }'" # APC UPS charge left
alias apc="apcaccess | grep -E 'MODEL|STATUS|LOADPCT|BCHARGE|TIMELEFT|NOMPOWER'" # Compact APC USP information

###################
# MEMORY
###################

# Frees up the cached memory
alias freemem2='sync && sudo /sbin/sysctl -w vm.drop_caches=3' # Free memory by droping caches 
alias mem_hogs_top='top -l 1 -o rsize -n 10' # Find memory hogs
alias mem_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10' # Find top 10 memory hogs:
alias psmem='ps auxf | sort -nr -k 4' # Get top process eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10' # Get top 10 process eating memory

###################
# NETWORKING
###################

alias flushdns='sudo service nscd restart ' # Flush DNS entries

# IPs and interfaces
#FIXME alias myip="nslookup . ifcfg.me | grep Address |tail -1 | awk '{print \$2}'" # Return public IP
alias myip="curl -s ifconfig.co"
alias mydns="nslookup . ifconfig.co | grep Name | awk '{print \$2}'" # Return public DNS FIXME
alias myips="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$4}'" # List all interfaces IPs
alias myif="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$2 \" \" \$4}'" # List all interfaces and their IPs
alias netinfo='__netinfo' # Show current network information
alias whatsmyip='__whatsmyip' # IP address lookup
alias whatsmyreversedns="host $(curl -s ifconfig.co) | awk '{ print substr(\$NF, 1, length(\$NF)-1)}'"


# Bandwidth for eth0 #TODO make function to accept interface parameter ? # FIXME
alias bw="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \"Download \" \$1 \"K Upload \" \$2 \"K\"}'" # Return download/upload bandwidth in K
alias bwu="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$2}'" # Return upload bandwidth in K
alias bwd="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$1}'" # Return download bandwidth in K

# Show open ports
alias listen="lsof -P -i -n" # lsof = list open ports
alias listen2='netstat -lt' # netstat - list listening ports tcp FIXME DUPLICATE ?
alias lsock='lsof -i -P' # lsof - display open sockets (the -P option to lsof disables port names)
alias openports='netstat -nape --inet' # netstat - tcp open ports



# Firewall on linux
alias ipt='sudo iptables' # iptables
alias iptlist='sudo iptables -L -n -v --line-numbers' # Display all firewall rules 
alias iptlistin='sudo iptables -L INPUT -n -v --line-numbers' # Display firewall input rules
alias iptlistout='sudo iptables -L OUTPUT -n -v --line-numbers' # Display firewall output rules
alias iptlistfw='sudo iptables -L FORWARD -n -v --line-numbers' # Display firewall forward rules

# Packet tracing #TODO function for different interfaces/ports # FIXME
alias pkt_trace='sudo tcpflow -i eth0 -c' # tcpflow - pkt_trace: for use in the following aliases FIXME USES eth0
alias smtp_trace='pkt_trace port smtp' # tcpflow - smtp_trace: to show all SMTP packets
alias http_trace='pkt_trace port 80' # tcpflow - http_trace: to show all HTTP packets
alias tcp_trace='pkt_trace tcp' # tcpflow - tcp_trace: to show all TCP packets
alias udp_trace='pkt_trace udp' # tcpflow - udp_trace: to show all UDP packets
alias ip_trace='pkt_trace ip' # tcpflow - ip_trace: to show all IP packets

#
alias wgetlist="wget -ca -e robots=off --no-parent --recursive --mirror -p --convert-links --wait=5 -A html --cut-dirs=1 --user-agent=Mozilla/5.0 -P wgets/ -i  " # wget - Parse $1 file as http files to download and save to this directory
debug_http () { curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; } # curl - debug_http: download a web page and show info on what took time
http_headers () { curl -I -L $@ ; } # curl - http_headers: get just the HTTP headers from a web page (and its redirects)

#Does it works with interfaces aliases ??
alias myip="nslookup . ifcfg.me | grep Address |tail -1 | awk '{print \$2}'" #Return public IP
alias mydns="nslookup . ifcfg.me | grep Name | awk '{print \$2}'" #Return public DNS
alias myips="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$4}'" #List all interfaces IPs
alias myif="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$2 \" \" \$4}'" #List all interfaces and their IPs



###################
# SERVICES
###################

#alias s-restart # Service restart
#alias s-search # Search for service
#alias s-status # Service status
#alias s-stop # Service stop


# 


###############################################################################
# SYSTEM
###############################################################################

# Debian based updating
alias apt-dup='sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y' # apt - update and dist-upgrade
alias apt-install='sudo apt-get install' # apt - install 
alias apt-search='apt-cache search' # apt - search
alias apt-show='apt-cache show' # apt - show
alias apt-purge='sudo apt-get --purge remove' # apt - remove and purge
alias apt-remove='sudo apt-get remove' # apt - remove 
alias apt-up="sudo apt-get update && sudo apt-get upgrade -y" # apt - update and upgrade

# Fedora based updating
# FIXME check if silverblue or regular
#alias dnf="podman run --rm -it registry.fedoraproject.org/fedora:29 dnf $@"

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot' # reboot - reboot
alias poweroff='sudo /sbin/poweroff' # poweroff - poweroff
alias halt='sudo /sbin/halt' # halt -halt
alias shutdown='sudo /sbin/shutdown -r now' # shutdown - safe shutdown
alias shutd='sudo /sbin/shutdown -P now' # shutdown - shutdown and poweroff FIXME
alias shutr='sudo /sbin/shutdown -r now' # shutdown -shutdown and reboot FIXME

# Frees up the cached memory
alias freemem='sync && echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias flush="" # FIXME

alias hosts="sudo vim /etc/hosts"

# Get system information
alias inxi="inxi -Fxzc0"

###############################
# Sudo and su
###############################

alias sudo="sudo -E " # sudo - pass environment variables when doing a sudo, usefull for $SSH_CLIENT and $TMUX for example
alias su="su -p " # su - pass environment variables when doing a su, usefull for $SSH_CLIENT and $TMUX for example

###################
# USERS
###################

#Show who is on
alias whoison='w -f -i -s' # who - check who is loggeg in and doing what
#alias whoisssh="sudo ps auxwww | grep sshd: | grep -v 'priv\|grep' | awk '{print \$12}' | sort" # List connected users from ssh
alias whoisssh="sudo netstat -tnpa | grep ESTABLISHED.*sshd | awk '{gsub(/\/.*/,\" \",\$7); print \$8\" from \"\$5\" \"\$7}'" # List connected uses from ssh with source IP

alias luser="sudo ps auxwww | grep sshd: | grep -v 'priv\|grep' | awk '{print \$12}' | sort" #List connected users from ssh FIXME
alias lssh="sudo netstat -tnpa | grep ESTABLISHED.*sshd | awk '{gsub(/\/.*/,\" \",\$7); print \$8\" from \"\$5\" \"\$7}'" #List connected uses from ssh with source IP FIXME




