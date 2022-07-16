local cmd = vim.cmd -- execute Vim commands
cmd[[
autocmd FileType purescript nnoremap <leader>ft :TmuxJumpFile purs<CR>
autocmd FileType purescript nnoremap <leader>; :TmuxJumpFirst purs<CR>
]]

cmd[[
autocmd FileType purescript nnoremap <silent> <buffer> <localleader>f :!purs-tidy format-in-place %<CR>
augroup abbreviation_ps
  autocmd! FileType purescript
  autocmd FileType purescript abbreviate fc flowConfig
  autocmd FileType purescript abbreviate ispy import Debug.Trace (spy)
augroup END
]]

