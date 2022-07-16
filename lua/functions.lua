
local cmd = vim.cmd -- execute Vim commands
cmd[[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]

cmd[[
function CopyLine(line) abort
  let l:win = winnr()
   wincmd w | exec a:line | exec 'norm yy' | exec l:win . 'wincmd w' | norm p
endfunction

function CopyPara(start,end)
  let l:win = winnr()
  let l:nlineBelow = a:end - a:start
   wincmd w | exec a:start | exec 'norm y'. l:nlineBelow .'j' | exec l:win . 'wincmd w' | norm p
endfunction

command -nargs=1 CLine call CopyLine(<args>)
command -nargs=* CPara call CopyPara(<f-args>)
nnoremap <leader>yy :CLine<space>
nnoremap <leader>yp :CPara<space>
]]
