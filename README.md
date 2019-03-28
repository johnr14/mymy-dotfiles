

# Mymy dotfiles

They are for all to see. I had done lots of work on them but lost the latest version after failed backup (to gdrive) and linux reinstall.
So I decided to put them on github. As I took a great deal of inspiration from other's files, I might as well give back.

GREAT NEWS !!! I FOUND A BACKUP ON ONE OF MY MACHINE !
IN PROCESS OF MERGING THEM BACK !

I found quite some bashrc and bash_aliases on the net. But few are actually ready for what I want.

I moved over to tmux for a simple reason, it supports striked text.

![Bash prompt as 2019-03](https://user-images.githubusercontent.com/5272079/54505513-89b1a000-490e-11e9-8497-5b7a0ef2c3f8.png)

![Bash login as 2019-03](https://user-images.githubusercontent.com/5272079/54684129-cb4a7280-4ae9-11e9-9a74-ae5d6265e086.png)

## NOTE :
This is a work in progress, there are many places that need some tweeking.
Use as reference. Some few nice hacks may be found here. I try to mark the url from where I took inspiration. Might have missed a few credits, the rest is my humble bash hacking.


### WARNING ! DO THIS IN A NEW USER TO TEST IT OUT BEFORE !!!
Remember, this is my backup for my work in progress changes to those files. It may brake at some point.
To clone those files : 
```bash
rm .bashrc .bash_aliases .bash_logout .profile .screenrc .tmux.conf .tmux.remote .tmux.renew.sh .vimrc
git init
git remote add origin https://github.com/johnr14/mymy-dotfiles.git
git pull origin master ```

## Noteworthy things :

Lots of tmux aliases 
```bash
WIP WILL BE ADDED LATER
```

### Structure
All stardard .dotfiles will be in $HOME. 
Additionnal files will be in folder $HOME/.mymydotfiles :
subfolders : 
$HOME/.mymydotfiles/scripts # Scripts folders
$HOME/.mymydotfiles/functions # Functions folder for sourcing from .bashrc of .bash_aliases
$HOME/.mymydotfiles/tmux # Tmux specific functions or scripts
$HOME/.mymydotfiles/screen # Screen specific functions or scripts
$HOME/.mymydotfiles/ssh # Ssh specific functions or scripts
$HOME/.mymydotfiles/avid # Audio or video specific functions or scripts
$HOME/.mymydotfiles/backup
$HOME/.mymydotfiles/

### History
History will be save in folder $HOME/.bash_history/ and under a unique identifier filename. This will enable per terminal history search with arrows without seeing what whas typed in other terminals.
You can search local history with h and global history with hh.
Multiplex all bash history across all tmux terminals.
Search only current pane history or global history.~~~

HISTTIMEFORMAT="$HOSTNAME $UNIQTTY $PWD %d/%m/%y %T :"
$UNIQTTY is : ssh@host | /dev/pts/XX | tmuxsession:windowname:pane  

