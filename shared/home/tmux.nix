{
    programs.tmux = {
    enable = true;
    extraConfig = ''
        unbind C-b
        set-option -g prefix C-space
        # Start window numbering at 1
        set -g base-index 1
        set -g allow-rename off
        set -g history-limit 10000
        set -g mouse on
        set-option -g status-fg "#5e5e5e"
        set-option -g status-bg "#151515"
        set-window-option -g window-status-current-style fg="#ab8550",bg="#151515"
        set-window-option -g window-status-style bg="#151515"
        set -g status-left " "
        set -g status-justify left
        setw -g window-status-format "#I:#W "          # window name formatting
        setw -g window-status-current-format "#I:#W "
        set -g status-right " "
        set -g message-command-style bg="#151515",fg="#c8c093"
        set -g message-style bg="#151515"
        bind-key -n S-Up set-option -g status
        bind-key -n S-Down set-option -g status
        bind-key -n S-Left previous-window
        bind-key -n S-Right next-window
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        bind -r C-H resize-pane -L 5
        bind -r C-J resize-pane -D 5
        bind -r C-K resize-pane -U 5
        bind -r C-L resize-pane -R 5
        # Pane border
        set -g pane-border-style bg=default,fg=colour238
        set -g pane-active-border-style fg="#E6C384"
        set -g pane-border-lines heavy 
        # loud or quiet?
        set-option -g visual-activity off
        set-option -g visual-bell off
        set-option -g visual-silence off
        set-window-option -g monitor-activity off
        set-option -g bell-action none
        set-option -g allow-rename off
        set -g prefix §                   # use tilde key as prefix
        bind <     swap-window -t :-
        bind >     swap-window -t :+
        bind ,     previous-window
        bind .     next-window
        bind q     kill-pane
        bind Q     kill-window
        bind H     split-window -h        # split into left and right panes
        bind V     split-window -v  
        bind r     source-file ~/.tmux.conf \; display-message " * reloaded ~/.tmux.conf"
        bind n     command-prompt "rename-window %%"
        bind N     command-prompt "rename-session %%"
        set -g default-terminal "xterm-256color"
        set -s escape-time 0
    '';
    };
}