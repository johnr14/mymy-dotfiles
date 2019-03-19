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

#
# cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -v "#" | sed -e 's/\=.*\#/ =/'| sort
# cat .bash_aliases | grep "^alias" | grep -E "#" | cat .bash_aliases | grep "^alias" | cut -d' ' -f2- | grep -E "#" | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sort | column -t -s:
#

################$###############################################
# Colors
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


###############################################################
# Alias helper                                          
###############################################################



alias alias-less="less $HOME/.bash_aliases" # alias - Show all aliases
alias alias-reload="source ~/.bash_aliases"  # alias - Reload only aliases
alias alias-search="cat .bash_aliases | grep '^alias' | grep -E '#' | cat .bash_aliases | grep '^alias' | cut -d' ' -f2- | grep -E '#' | sed -e 's/\=.*\#/ : /' | tr -s ' ' | sort | column -t -s: | grep " # alias - Show all aliases TODO
alias alias-viewcmd="" # alias - Show cmd for an alias
#cat .bash_aliases | grep "^alias" | sort



###############################################################
#BASH related                                           
###############################################################

# Search command line history
alias h="history | grep -i"
alias mostused="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -15" #Most used cmd
alias hh="history | tail -35" #Return last 35 cmd run
alias hs='history | grep -i '
alias lspath='echo -e ${PATH//:/\\n}' #List paths
alias reload='source $HOME/.bashrc'     # Reload bashrc 


alias allttys="ps a | grep -vi 'tty*' " # ps - list all opened tty


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
alias tmuxcpa="tmux display -pt "${TMUX_PANE:?}" '#{session_name}:#{window_name}:#{pane_title}'" # tmux - current session.window:pane names


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


alias __cpu="grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage}' | awk '{printf(\"%.1f\n\", \$1)}'"

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
copy()
{
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


