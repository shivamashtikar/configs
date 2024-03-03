local cmd = vim.cmd -- execute Vim commands
cmd[[
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>f :RescriptFormat<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>, :RescriptTypeHint<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>b :RescriptBuild<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>d :RescriptJumpToDefinition<CR>
]]
