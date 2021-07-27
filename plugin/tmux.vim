" vim-tmux | Copyright (C) 2021 eth-p | MIT License
scriptencoding utf-8

" Only load once.
if exists('g:loaded_tmux')
	finish
endif
let g:loaded_tmux = 1


" -----------------------------------------------------------------------------
" Wcmd:
" -----------------------------------------------------------------------------

let s:run_on_save = {}

function s:RunOnSave(buffer, pane, command)
	" Select the pane.
	let pane = a:pane
	if pane == ""
		let pane = tmux#GetMarkedPane()
		if pane == ""
			echohl ErrorMsg
			echo "A marked tmux pane is required."
			echohl None
			return
		endif
	endif

	" Select the buffer.
	let buffer = a:buffer
	if buffer == ""
		let buffer = bufnr('%')
	endif

	" Remove if "-" or empty.
	if a:command == "-" || a:command == ""
		unlet s:run_on_save[pane]
		echo "Unbound command from tmux pane ".pane."."
		return
	end

	" Add.
	let s:run_on_save[pane] = 
		\ {
		\     'buffer': buffer, 
		\     'cwd': getcwd(),
		\     'command': a:command
		\ }

	echo "Bound command to tmux pane ".pane."."
endfunction

function s:RunOnSaveDo(buffer, path)
	for hook in items(s:run_on_save)
		let pane = hook[0]
		let buffer = hook[1].buffer
		let command = hook[1].command
		let cwd = hook[1].cwd

		if buffer == a:buffer
			call tmux#Command('respawn-pane', '-k', '-t', pane,
				\ "bash -c 'cd \"$1\" && \"${@:2}\"; echo \"--- exit ($?) ---\"; trap \"exec \\\"\\$SHELL\\\"\" INT; while true; do sleep 60; done; \"$SHELL\" -l' -- ".shellescape(cwd)." ".command
				\ )
		endif
	endfor
endfunction

augroup tmux
	autocmd BufWritePost * call s:RunOnSaveDo(expand('<abuf>'),expand('<afile>'))
augroup END

command! -nargs=1 Wcmd call s:RunOnSave("", "", <q-args>)

