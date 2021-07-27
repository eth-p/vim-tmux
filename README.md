# vim-tmux

My `vim` plugin for adding `tmux` integration.



## Installation

Just install this plugin with your favorite Vim plugin manager!

```
eth-p/vim-tmux
```



## Features

- Command: `Wcmd [shell command...]`
  Run a shell command on save.  
  
  Runs `[shell command...]` in the tmux pane that was marked when `Wcmd` was called.



## Reference

Along with integrations, this also contains useful utility functions:

> **tmux#Enabled()**
> Checks if vim is running from inside tmux.

> **tmux#GetMarkedPane()**
> Returns the ID of the marked pane in the current tmux session.
> If no pane is marked, an empty string will be returned.

> **tmux#Command(...)**
> Runs a `tmux` command.
