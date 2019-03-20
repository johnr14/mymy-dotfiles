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

#
# cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -v "#" | sed -e 's/\=.*\#/ =/'| sort
# cat .bash_aliases | grep "^alias" | grep -E "#" | cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -E "#" | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sort | column -t -s:
#

################################################################
# Colors & symbols
################################################################
# not searchable

#Must encapsulate in \[ \] https://unix.stackexchange.com/questions/28827/why-is-my-bash-prompt-getting-bugged-when-i-browse-the-history
BLACK='\[\e[0;30m\]'
BLUE='\[\e[0;34m\]'
GREEN='\[\e[0;32m\]'
CYAN='\[\e[0;36m\]'
RED='\[\e[0;31m\]'
PURPLE='\[\e[0;35m\]'
BROWN='\[\e[0;33m\]'
LIGHTGRAY='\[\e[0;37m\]'
DARKGRAY='\[\e[1;30m\]'
LIGHTBLUE='\[\e[1;34m\]'
LIGHTGREEN='\[\e[1;32m\]'
LIGHTCYAN='\[\e[1;36m\]'
LIGHTRED='\[\e[1;31m\]'
MAGENTA='\[\e[1;35m\]'
YELLOW='\[\e[1;33m\]'
LIGHTYELLOW='\[\e[0;93m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]' # No Color
OFF="\[\033[m\]"


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
alias alias-search="cat .bash_aliases | grep '^alias' | grep -E '#' | cat .bash_aliases | grep '^alias' | cut -d' ' -f2- | grep -E '#' | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sort | column -t -s: | grep " # alias - Show all aliases TODO
alias alias-viewcmd="" # alias - Show cmd for an alias
#cat .bash_aliases | grep "^alias" | sort

#FIXME ?
alias aliassearch='__aliassearch' # Search for alias by keyword

#######################################
# BACKUP RELATED
#######################################

#alias bkbash='__bkbash' # Backup bash configuration files

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

###############################################################
# Bash related                                           
###############################################################

###############################
# History                     
###############################
alias h="history | grep -i"
alias mostused="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -15" # History - most used cmd
alias hh="history | tail -35" # history - return last 35 cmd run
#alias hs='history | grep -i ' # 
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr" # history - shows most 

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


#Screen related
alias c='clear' # Clear the screen
alias cla='clear; la' # Clear screen and list all
alias cld='clear; lsd' # Clear screen and list directories
alias cls='clear; ls' # Clear screen and list

#Terminal related
alias fix='echo -e "\033c"' # Fix terminal when weird caracters replaced prompt; after cat a binary file

#######################################
# CHECKSUM SHA AND MD5
#######################################

#FIXME pipe data?
alias opensslsha1="openssl dgst -sha1" # openssl dgst -sha1
alias opensslsha2="openssl dgst -sha256" # openssl dgst -sha256
alias opensslsha512="openssl dgst -sha512" # openssl dgst -sha512
alias opensslb64="openssl enc -base64" # openssl enc -base64

#######################################
# CODING RELATED
#######################################

#Compilling FIXME more optimisation fox avx ?
alias compc="gcc -o exe -O3 -lm -W -Wall -Wuninitialized -fbounds-check "

#Git #FIXME probably more complete/useful versions?
alias gs='git status' # Git status
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # Git log 
alias ga='git add' # Git add
alias gc='git commit -am' # Git commit
alias gu='git up' # Git up
alias gp='git push' # Git push
alias gd='git diff' # Git diff 
alias gb='git branch' # Git branch
alias gup='gu && gp' # Git up and git push
alias gcup='gc && gup' # Git commit and git up and push

#######################################
# COLORIZE
#######################################

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto -i'   # Colorized grep
alias egrep='egrep --color=auto -i' # Colorized egrep
alias fgrep='fgrep --color=auto -i' # Colorized fgrep

# Install  colordiff package :)
alias diff='colordiff' # Colorized diff

#######################################
# COMPRESSION AND DECOMPRESSION
#######################################

# Compressed files
alias ex='__ex' # Extract compressed file by matching extension

#######################################
# DESKTOP RELATED
#######################################

# valid .Xauthority


#######################################
# FILES AND DIRECTORIES
#######################################

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
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bash_ohmy_bookmarks'   # Save bookmarked directories alias (g1-g9)
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
alias lsx='ls -lXBh' # sort by extension
alias lsk='ls -lSrh' # sort by size
alias lsc='ls -lcrh' # sort by change time
alias lsu='ls -lurh' # sort by access time
alias lst='ls -ltrh' # sort by date

# Remove empty directories
alias rmdirempty='find . -type d -empty -delete' # Remove all empty directories recursively

#######################################
# LANGUAGE
#######################################

#MORE ??
alias orthographe="aspell -t check --lang=fr "
alias spellcheck="aspell -t check --lang=en "

#######################################
# MOUNTS AND SPACE
#######################################

alias dfc='dfc -W -d -s -T -t ext2,ext3,ext4,zfs,btrfs,fuseblk,ntfs,fat,xfs,nfs 2>/dev/null' # Show colorized mounts of real filesystems with bars
alias mounts="mount | grep -v 'cgroup\|sysfs\|tmpfs\|proc\|debugfs\|securityfs\|devpts\|mqueue\|pstore\|hugetlbfs'" # Show mounts only

#SSH MOUNTS
#alias sshmounts=


#######################################
# MOVING FILES AND DIRECTORIES 
#######################################

alias copy='__copy()' # Copy file with a progress bar

#######################################
# NETWORKING
#######################################

alias ping='ping -c 5 ' # ping -c 5

#Debug http
debug_http () { curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; } # WARN:TOCHECK debug_http: download a web page and show info on what took time
http_headers () { curl -I -L $@ ; } # WARN:TOCHECK http_headers: get just the HTTP headers from a web page (and its redirects)

#Downloading
alias wget='wget -c' # wget -c for resuming
alias wgetlist="wget -ca -e robots=off --no-parent --recursive --mirror -p --convert-links --wait=5 -A html --cut-dirs=1 --user-agent=Mozilla/5.0 -P wgets/ -i  " # WARN:TOCHECK Parse $1 file as http files to download and save to wgets directory 


#######################################
# PARSING PIPES 
#######################################
alias lessl='__lessl' # A less that scroll to line number #

#######################################
# PROCESS RELATED
#######################################

#TODO More jobs
alias j='jobs -l' # Current running jobs

alias p="ps aux | grep " # ps aux | grep 
alias psn='ps aux | tail -n +2 | wc -l' # Total number of processes running
alias psu='ps -fHU $USER' # ps for current user

alias pskill='__pskill' # Kill a process by name

#TODO NICE

#######################################
# SCREEN, SSH & TMUX RELATED
#######################################

# SCREENS
alias screens='screen -list' # List screen
alias screenconnect='__screenconnect' # Connect to screen #n or PID.NAME
alias screenrename='__screenrename' # Rename screen session name, accept: [screen# | screensession | empty ] newname

#alias screenlaunch='__screenlaunch' # Start a new screen and start application
#alias screenlaunchdetach='__screenlaunchd' # Start a new screen, start application and detatch

# Am I running on a screen, ssh or tmux session ?
alias isscreen='__issc' # Check if running from a screen
alias isssh='__isssh' # Check if curently in a ssh session

#TODO
# alias istmux='__istmux' # Check if currently running in a tmux session
# alias iswhat # Draw tree of parent process

#alias scw='__scw' # Find what screens are doing
#alias tmuxw='__tmuxw' # Find what tmux are doing

# Where do I have active ssh connections to 
# alias sshwhere='__sshwhere' # Where do I have active ssh connections
# alias sshwhat='__sshwhat' # What is running on my ssh connections

#SSH 
alias sshfromwhere="echo $SSH_CLIENT | awk '{ print $1 }'" # Find client originating ip on remote host



#ps u -p $(ps -el | grep $(ps -el | grep SCREEN_SESSION_PID | grep bash | awk '{print $4}') | grep -v bash | awk '{print $4}')

#

#######################################
# RANDOM RELATED
######################################
alias randpass8='__randpassgen 8' # Generate a random password of size 8
alias randpass16='__randpassgen 16' # Generate a random password of size 16
alias randpass32='__randpassgen 32' # Generate a random password of size 32
alias randpass64='__randpassgen 64' # Generate a random password of size 64

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
 
alias apcwatt="__apcwatt" # Return watts used on APC connected UPS
alias apcleft="sudo apcaccess | grep 'TIMELEFT' | awk '{ print $3 }'" # APC UPS time left on battery
alias apccharge="sudo apcaccess | grep 'BCHARGE' | awk '{ print $3 }'" # APC UPS charge left
alias apc="sudo apcaccess | grep -E 'MODEL|STATUS|LOADPCT|BCHARGE|TIMELEFT|NOMPOWER'" # Compact APC USP information

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
alias myip='curl ifconfig.co'
alias mydns="nslookup . ifconfig.co | grep Name | awk '{print \$2}'" # Return public DNS
alias myips="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$4}'" # List all interfaces IPs
alias myif="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$2 \" \" \$4}'" # List all interfaces and their IPs
alias netinfo='__netinfo' # Show current network information
alias whatsmyip='__whatsmyip' # IP address lookup


# Bandwidth for eth0 #TODO make function to accept interface parameter ? #FIXME
alias bw="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \"Download \" \$1 \"K Upload \" \$2 \"K\"}'" # Return download/upload bandwidth in K
alias bwu="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$2}'" # Return upload bandwidth in K
alias bwd="sudo ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$1}'" # Return download bandwidth in K

# Show open ports
alias openports='netstat -nape --inet' # Find open ports
alias ports="lsof -P -i -n" # List open ports
alias listen='netstat -lt' # List listening ports tcp
alias lsock='lsof -i -P' # Display open sockets (the -P option to lsof disables port names)

# Firewall on linux
alias ipt='sudo iptables' # iptables
alias iptlist='sudo iptables -L -n -v --line-numbers' # Display all firewall rules 
alias iptlistin='sudo iptables -L INPUT -n -v --line-numbers' # Display firewall input rules
alias iptlistout='sudo iptables -L OUTPUT -n -v --line-numbers' # Display firewall output rules
alias iptlistfw='sudo iptables -L FORWARD -n -v --line-numbers' # Display firewall forward rules

# Packet tracing #TODO function for different interfaces/ports #FIXME
alias pkt_trace='sudo tcpflow -i eth0 -c' # pkt_trace: for use in the following aliases #FIXME
alias smtp_trace='pkt_trace port smtp' # smtp_trace: to show all SMTP packets
alias http_trace='pkt_trace port 80' # http_trace: to show all HTTP packets
alias tcp_trace='pkt_trace tcp' # tcp_trace: to show all TCP packets
alias udp_trace='pkt_trace udp' # udp_trace: to show all UDP packets
alias ip_trace='pkt_trace ip' # ip_trace: to show all IP packets


###################
# SERVICES
###################

#alias s-restart # Service restart
#alias s-search # Search for service
#alias s-status # Service status
#alias s-stop # Service stop


###################
# SYSTEM
###################

# Debian based updating
alias apt-upgrade='sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y' # apt dist-upgrade
alias apt-install='sudo apt-get install' # apt install 
alias apt-search='apt-cache search' # apt search
alias apt-show='apt-cache show' # apt show
alias apt-purge='sudo apt-get --purge remove' # apt remove and purge
alias apt-remove='sudo apt-get remove' # apt remove
alias apt-up="sudo apt-get update && sudo apt-get upgrade" # apt upgrade

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot' # reboot
alias poweroff='sudo /sbin/poweroff' # poweroff
alias halt='sudo /sbin/halt' # halt
alias shutdown='sudo /sbin/shutdown -r now' # Safe shutdown
alias shutd='sudo /sbin/shutdown -P now' # shutdown and poweroff FIXME
alias shutr='sudo /sbin/shutdown -r now' # shutdown and reboot FIXME

###################
# USERS
###################

#Show who is on
alias whoison='w -f -i -s'
alias luser="sudo ps auxwww | grep sshd: | grep -v 'priv\|grep' | awk '{print \$12}' | sort" # List connected users from ssh
alias lssh="sudo netstat -tnpa | grep ESTABLISHED.*sshd | awk '{gsub(/\/.*/,\" \",\$7); print \$8\" from \"\$5\" \"\$7}'" # List connected uses from ssh with source IP




#MORE CLEANING NEEDED
###########-------------------------------------------------------------


###############################
# Sudo and su
###############################

alias sudo="sudo -E " # sudo - pass environment variables when doing a sudo, usefull for $SSH_CLIENT and $TMUX for example
alias su="su -p " # su - pass environment variables when doing a su, usefull for $SSH_CLIENT and $TMUX for example
# 

#Simple args
#alias cp="cp -iv"      # interactive, verbose
#alias rm="rm -i"      # interactive
#alias mv="mv -iv"       # interactive, verbose

#COPY AND MOVE with progress bar over local & SSH
#vcp="rsync --info=progress2 " #Copy with progress

alias d=date # Return date


# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto -i'
alias egrep='egrep --color=auto -i'
alias fgrep='fgrep --color=auto -i'

# install  colordiff package :)
alias diff='colordiff'

#PROCESS RELATED
# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

alias j='jobs -l' # Current running jobs

alias psg='ps aux | grep '
alias psu='ps -fHU $USER'


#FILES & DIR RELATED
alias ff="find . -name $1" # Find file by name

alias ax="chmod a+x" # make executable
alias or="chmod o+r" # make readable by all
alias ux="chmod u+r" # make user executable

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

alias bigfiles='find -type f -printf "%s %p\n" | sort -nr | head -n 40 | numfmt --field=1 --to=iec-i'

#Mounts and space
alias dfc='dfc -d -s -T -t ext2,ext3,ext4,zfs,btrfs,fuseblk,ntfs,fat,+se.mergerfs,fuse 2>/dev/null'
alias mounts="mount | grep -v 'cgroup\|sysfs\|tmpfs\|proc\|debugfs\|securityfs\|devpts\|mqueue\|pstore\|hugetlbfs'" #Show mounts only

# easy navigation: .., ..., .... and .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cdh='cd ~'

# Alter the ls command
alias ll='ls -F --color --time-style="+%d %b %Y %H:%M"' #List
alias ls='ls -lacf --color' #List files in colors
alias lls='ls -lacF' #List files in colors, directories end with /
alias la="ls --color -lAGbhF --time-style='+%d %b %Y %H:%M'  --group-directories-first"
alias lx="ls --color -lGbhFXB --time-style='+%d %b %Y %H:%M' | grep -v /" #List files by extensions
alias lf="ls --color -lGbhF --time-style='+%d %b %Y %H:%M' | grep -v /" #List files by filename
alias lsd="ls -ld --color -tolAGbhF --time-style='+%d %b %Y %H:%M' */" #List directories only
alias llt="ls -thor --time-style='+%d %b %Y %H:%M' | head " #List most recent file changed
alias llta="ls -thor --time-style='+%d %b %Y %H:%M'" #List files ordered with most recent on top

# Alias's for multiple directory listing commands
alias la='ls -Alh --color=always' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
#alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
#alias lm='ls -alh |more' # pipe through 'more'
#alias lw='ls -xAh' # wide listing format
#alias ll='ls -Fls' # long listing format
#alias labc='ls -lap' #alphabetical sort
#alias lf="ls -l | egrep -v '^d'" # files only
#alias ldir="ls -l | egrep '^d'" # directories only

# Bash Directory Bookmarks http://www.huyng.com/posts/quick-bash-tip-directory-bookmarks/
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'   #Save directories alias
alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"' #list directories alias
touch ~/.bookmarks
source ~/.bookmarks


alias c='clear' # Clear the screen
alias cla='clear;la'
alias cld='clear;lsd'
alias cls='clear;ls'

#CODING RELATED
#Git
alias gs='git status'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ga='git add'
alias gc='git commit -ma'
alias gu='git up'
alias gp='git push'
alias gd='git diff'
alias gb='git branch'
alias gup='gu && gp'
alias gcup='gc && gup'


#ADMIN RELATED
# Monitoring
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias syslog='sudo tail -100f /var/log/syslog'
alias messages='sudo tail -100f /var/log/messages'

alias allcron='for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; done' # list all crontab jobs for all users, in sudo !

#alias fuck='sudo $(history -p \!\!)' #Run last cmd as root


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
alias diskwho='sudo iotop' # Show processes reading/writing to disk

#BTRFS
#ZFS

# Upgrade/update system
alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y'
alias apt-install='sudo apt-get install'
alias apt-search='apt-cache search'
alias apt-show='apt-cache show'
alias apt-purge='sudo apt-get --purge  remove'
alias apt-remove='sudo apt-get remove'
alias apt-up="sudo apt-get update && sudo apt-get upgrade"

#Show who is on
alias luser="sudo ps auxwww | grep sshd: | grep -v 'priv\|grep' | awk '{print \$12}' | sort" #List connected users from ssh
alias lssh="sudo netstat -tnpa | grep ESTABLISHED.*sshd | awk '{gsub(/\/.*/,\" \",\$7); print \$8\" from \"\$5\" \"\$7}'" #List connected uses from ssh with source IP

alias hosts="sudo vim /private/etc/hosts"

# Frees up the cached memory
alias freemem='sync && echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias flush="dscacheutil -flushcache"

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias shutd='sudo shutdown -P now'
alias shutr='sudo shutdown -r now'

#NETWORK RELATED

#ALIAS THAT MAY CHANGE :
#alias myhost='ssh -T user@my.remote.host screen -dAr'

#Does it works with interfaces aliases ??
alias myip="nslookup . ifcfg.me | grep Address |tail -1 | awk '{print \$2}'" #Return public IP
alias mydns="nslookup . ifcfg.me | grep Name | awk '{print \$2}'" #Return public DNS
alias myips="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$4}'" #List all interfaces IPs
alias myif="ip -o addr show scope global | awk '{gsub(/\/.*/, \" \",\$4); print \$2 \" \" \$4}'" #List all interfaces and their IPs

alias bw="ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \"Download \" \$1 \"K Upload \" \$2 \"K\"}'" #Return download/upload bandwidth in K
alias bwu="ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$2}'" #Return upload bandwidth in K
alias bwd="ifstat -i eth0 -q 1 1 | tail -1 | awk '{print \$1}'" #Return download bandwidth in K

# Show open ports
alias openports='netstat -nape --inet'

## shortcut for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# Show open ports
alias openports='netstat -nape --inet'
alias listen="lsof -P -i -n" #List open ports

alias lsock='sudo /usr/sbin/lsof -i -P' #to display open sockets (the -P option to lsof disables port names)

# pkt_trace: for use in the following aliases
alias pkt_trace='sudo tcpflow -i eth0 -c'
# smtp_trace: to show all SMTP packets
alias smtp_trace='pkt_trace port smtp'
# http_trace: to show all HTTP packets
alias http_trace='pkt_trace port 80'
# tcp_trace: to show all TCP packets
alias tcp_trace='pkt_trace tcp'
# udp_trace: to show all UDP packets
alias udp_trace='pkt_trace udp'
# ip_trace: to show all IP packets
alias ip_trace='pkt_trace ip'

#WWW RELATED
alias wgetlist="wget -ca -e robots=off --no-parent --recursive --mirror -p --convert-links --wait=5 -A html --cut-dirs=1 --user-agent=Mozilla/5.0 -P wgets/ -i  " #Parse $1 file as http files to download and save to wgets directory
# debug_http: download a web page and show info on what took time
debug_http () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# http_headers: get just the HTTP headers from a web page (and its redirects)
http_headers () { /usr/bin/curl -I -L $@ ; }

#GUI RELATED
# Allow local users to use my X session
# xhost +local:

# I can't remember the new gnome command!
alias gtop='/usr/bin/gnome-system-monitor'

# xterm
# alias xterm='xterm -bg black -fg green'


#FUNCTIONS

randpassgen() { < /dev/urandom tr -dc A-Za-z0-9_ | head -c$1 ; echo; }
alias randpass8='randpassgen 8'
alias randpass='randpass8'
alias randpass16='randpassgen 16'
alias randpass32='randpassgen 32'
alias randpass64='randpassgen 64'





alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias sha512="openssl dgst -sha512"
alias b64="openssl enc -base64"


#battery status
alias bat_status='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep  -E "state|to\ full|percentage|time to empty"'



md5check() { md5sum "$1" | grep "$2";} #md5check [file] [key]



###############################
# TMUX            
###############################

# If tmux is not accessible, line in a sudo, you may get errors trying to parse those aliases
if [ -n "$TMUX" ]; then

#######################
# Get information
#######################

###############
# Get session info
###############
alias tmuxs="tmux display-message -p '#S'" # tmux - current session name
alias tmuxta="tmux list-panes -a -F '#{pane_tty} #{session_name}'" # tmux - list all terminals attatched to tmux server
alias tmuxls="tmux ls" # tmux - list all sessions

###############
# Get window info
###############
alias tmuxt="" # tmux - list terminals attached to current window
alias tmuxw="tmux display-message -p '#W'" # tmux - display current window name

alias tmuxlw="tmux list-windows -a" # tmux - list windows for all sessions
alias tmuxlcw="tmux list-windows" # tmux - list current sessions windows

###############
# Get pane info
###############

alias tmuxlcp="tmux list-panes -s -F '#{session_name}:#{window_name}.#{pane_title}' -t $(tmux display-message -p '#S')" # tmux - list panes and windows in current session
alias tmuxlp="tmux list-panes -s -F '#{session_name}:#{window_name}.#{pane_title}' -a" # tmux - list panes and windows in all sessions
alias tmuxcp="tmux display -pt "${TMUX_PANE:?}" '#{pane_title}'" # tmux - current pane name
alias tmuxcpa="tmux display -pt "${TMUX_PANE:?}" '#{session_name}:#{window_name}.#{pane_title}'" # tmux - current session.window:pane names


#######################
# Set configuration
#######################

# tmux display -pt "${TMUX_PANE:?}" '#{pane_index}' # tmux - list sessions.windows.panes
# I=$(tmux list-panes -a | grep $TMUX_PANE 2>/dev/null | awk -F: '{print $2}' | awk -F. '{print $2}') # Get current pane number

###############
#Rename
###############

alias tmuxrs="tmux rename-session -t $(tmux display-message -p '#S') " # tmux - rename current session
alias tmuxrw="tmux rename-window -t $(tmux display-message -p '#I') " # tmux - rename current window
alias tmuxrp="tmux select-pane -t $(tmux display -pt ${TMUX_PANE:?} '#{pane_index}') -T " #tmux - rename current panel

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


###############################################################
# I can make noises.                                          #
###############################################################
alias beep='echo -en "\007"'


###############
# COMPLETIONS #
###############

shopt -s extglob progcomp cdspell

# Make directory commands see only directories
complete -d cd mkdir rmdir pushd

# Make file commands see only files
complete -f cat less more chown ln strip nedit emacs vi vim

complete -f -X '!*.@(zip|ZIP|jar|JAR|exe|EXE|pk3|war|wsz|ear|zargo|xpi)' unzip zipinfo
complete -f -X '*.Z' compress
complete -f -X '!*.@(Z|gz|tgz|Gz|dz)' gunzip zcmp zdiff zcat zegrep zfgrep zgrep zless zmore
complete -f -X '!*.Z' uncompress
complete -f -X '!*.@(gif|jp?(e)g|tif?(f)|pn[gm]|p[bgp]m|bmp|xpm|ico|xwd|tga|pcx|GIF|JP?(E)G|TIF?(F)|PN[GM]|P[BGP]M|BMP|XPM|ICO|XWD|TGA|PCX)' ee display
complete -f -X '!*.@(gif|jp?(e)g|tif?(f)|png|p[bgp]m|bmp|x[bp]m|rle|rgb|pcx|fits|pm|GIF|JPG|JP?(E)G|TIF?(F)|PNG|P[BGP]M|BMP|X[BP]M|RLE|RGB|PCX|FITS|PM)' xv qiv
complete -f -X '!*.@(ps|PS)' gv ggv
complete -f -X '!*.@(ps|PS|pdf|PDF)' fmerge
complete -f -X '!*.@(dvi|DVI)?(.@(gz|Z|bz2))' xdvi
complete -f -X '!*.@(dvi|DVI)' dvips dviselect dvitype
complete -f -X '!*.@(pdf|PDF)' acroread gpdf xpdf
complete -f -X '!*.texi*' makeinfo texi2html
complete -f -X '!*.@(?(la)tex|?(LA)TEX|texi|TEXI|dtx|DTX|ins|INS)' tex latex slitex jadetex pdfjadetex pdftex pdflatex texi2dvi
complete -f -X '!*.fig' xfig
complete -f -X '!*.@(?([xX]|[sS])[hH][tT][mM]?([lL]))' netscape mozilla lynx appletviewer hotjava
complete -f -X '!*.tar' tar
complete -f -X '!*.java' javac
complete -f -X '!*.idl' idl idlj

# user commands see only users
complete -u su usermod userdel passwd write groups w talk

# bg completes with stopped jobs
complete -A stopped -P '%' bg

# other job commands
complete -j -P '%' fg jobs disown

# readonly and unset complete with shell variables
complete -v readonly unset

# set completes with set options
complete -A setopt set

# shopt completes with shopt options
complete -A shopt shopt

# unalias completes with aliases
complete -a unalias

# type and which complete on commands
complete -c command type which

# complete hostnames
complete -A hostname ssh telnet rlogin ftp ping traceroute



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

# Searches for text in all files in the current folder
ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
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
netinfo ()
{
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	echo ""
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	echo ""
	/sbin/ifconfig | awk /'inet addr/ {print $4}'

	/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
	# Dumps a list of all IP addresses for every device
	# /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

	# Internal IP Lookup
	echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

	# External IP Lookup
	echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q
}

#get a certain column of the output, as in df -h | awk '{print $2}' = df -h|fawk 2

function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}


#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > ~/listdufolderlist.tmp
egrep '^ *[0-9.]*M' ~/listdufolderlist.tmp
egrep '^ *[0-9.]*G' ~/listdufolderlist.tmp
rm -rf ~/listdufolderlist.tmp
}


