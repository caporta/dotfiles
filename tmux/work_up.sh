#!/bin/bash


session='work'

tmux new -d -s $session -x "$(tput cols)" -y"$(tput lines)"
tmux splitw -p 20

tmux selectp -t $session:.1
tmux attach -t $session
