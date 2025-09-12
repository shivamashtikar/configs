local cmd = vim.cmd -- execute Vim commands
cmd[[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]]
-- automatically rebalance windows on vim resize
cmd[[ autocmd VimResized * :wincmd = ]]

cmd[[au BufNewFile,BufRead Jenkinsfile setf groovy]]

cmd[[augroup LargeFile
        let g:large_file = 10485760 " 10MB

        " Set options:
        "   eventignore+=FileType (no syntax highlighting etc
        "   assumes FileType always on)
        "   noswapfile (save copy of file)
        "   bufhidden=unload (save memory when other file is viewed)
        "   buftype=nowritefile (is read-only)
        "   undolevels=-1 (no undo possible)
        au BufReadPre *
                \ let f=expand("<afile>") |
                \ if getfsize(f) > g:large_file |
                        \ set eventignore+=FileType |
                        \ setlocal noswapfile bufhidden=unload undolevels=-1 |
                \ else |
                        \ set eventignore-=FileType |
                \ endif
augroup END]]

-- Set up yank highlighting
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- Create the autocmd for highlighting on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ timeout = 200, higroup = 'YankHighlight' })
    end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
