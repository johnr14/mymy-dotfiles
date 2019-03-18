

# Mymy dotfiles

They are for all to see. I had done lots of work on them but lost the latest version after failed backup (to gdrive) and linux reinstall.
So I decided to put them on github. As I took a great deal of inspiration from other's files, I might as well give back.

I moved over to tmux for a simple reason, it supports striked text.

![Bash prompt as 2019-03](https://user-images.githubusercontent.com/5272079/54505513-89b1a000-490e-11e9-8497-5b7a0ef2c3f8.png)

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
git pull origin master



