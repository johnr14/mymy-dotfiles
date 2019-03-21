#./.tmux.sessions
#!/bin/bash -f

SESSION="Monitoring"
# set up session
tmux -2 new-session -d -s $SESSION

# create window; split into panes
tmux new-window -t $SESSION:0 -n 'My Window with a Name'
