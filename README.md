# vim-tmux

My `vim` plugin for adding `tmux` integration.



## Installation

Just install this plugin with your favorite Vim plugin manager!

```
eth-p/vim-tmux
```



## Features

- `:Wcmd [command...]` - Run a command on save.

  This will run `[command...]` in the marked tmux pane whenever the current buffer is saved.



## Reference

Along with integrations, this also contains useful utility functions:

> **tmux#Enabled()**
> Checks if vim is running from inside tmux.

> **tmux#GetMarkedPane()**
> Returns the ID of the marked pane in the current tmux session.
> If no pane is marked, an empty string will be returned.

> **tmux#Command(...)**
> Runs a `tmux` command.
