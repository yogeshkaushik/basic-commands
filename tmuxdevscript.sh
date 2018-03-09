#!/bin/sh

#Check if a session already doesn't exist
tmux has-session -t development
if [ $? != 0 ]
then
    #create a new session with name development with a window named editor and detach from the session (-d)
    tmux new-session -s development -n editor -d
    #send-keys sends a command to a window.
    #C-m marks the end of the command
    tmux send-keys -t development "cd ~/dev/devproject" C-m
    tmux send-keys -t development "vim" C-m
    #create a new pane
    tmux split-window -v -t development
    #change the layout
    tmux select-layout -t development main-horizontal
    #send a comand to the new pane. Panes are addressed using the following convention:
    # session:window-index.pane-index, so here it is development:1.2
    tmux send-keys -t development:1.2 "cd ~/dev/devproject" C-m
    #create a new window named "console" in session "development"
    tmux new-window -n console -t development
    #execute some commands on the second window
    tmux send-keys -t development:2 "cd ~/dev/devproject" C-m
    #switch to the first window
    tmux select-window -t development:1
fi
#now attach to the session
tmux attach -t development
