" vim-tmux | Copyright (C) 2021 eth-p | MIT License
scriptencoding utf-8

" Wait for the plugin to load.
if !exists('g:loaded_tmux')
	finish
endif


" -----------------------------------------------------------------------------
" Library Functions:
" -----------------------------------------------------------------------------

" Checks if running in tmux.
function tmux#Enabled()
	return $TMUX != ""
endfunction

" Runs a tmux command.
function tmux#Command(...)
	if ! tmux#Enabled()
		echoerr "Not running in tmux."
		return
	endif
	
	let shellcmd = "tmux"
	for arg in a:000
		let shellcmd = shellcmd." ".shellescape(arg)
	endfor

	return system(shellcmd)
endfunction

" Gets the ID of the marked pane.
function tmux#GetMarkedPane()
	if ! tmux#Enabled()
		echoerr "Not running in tmux."
		return
	endif

	let panes = tmux#Command("list-panes", "-F", '#{pane_id} #{pane_marked}')
	for line in split(panes, "\n")
		let line_split = split(line)
		if line_split[1] == "1"
			return line_split[0]
		endif
	endfor

	return ""
endfunction

