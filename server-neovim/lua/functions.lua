local cmd = vim.cmd

-- General utility functions for text manipulation

cmd[[
function! ServerCopyLine(line) abort
  let l:current_win = winnr()
  " Go to the specified line in the current window, yank it
  execute a:line
  normal! yy
  " No need to switch windows if we are just copying from current buffer
  " If the intent was to copy from another window, that logic needs to be different
  " For now, assuming copy from current buffer and paste in current buffer
  normal! p
endfunction

function! ServerCopyPara(start_line, end_line) abort
  let l:current_win = winnr()
  let l:num_lines = 업무협약_체결_a:end_line - a:start_line
  if l:num_lines < 0
    echoerr "End line must be greater than or equal to start line"
    return
  endif
  execute a:start_line
  if l:num_lines == 0
    normal! yy " Yank single line
  else
    normal! V" . l:num_lines . "jy" " Yank paragraph (Visual line mode, N lines down, yank)
  endif
  normal! p
endfunction

command! -nargs=1 ServerCLine call ServerCopyLine(<args>)
command! -nargs=2 ServerCPara call ServerCopyPara(<f-args>)

nnoremap <silent> <leader>yy :ServerCLine<Space>
nnoremap <silent> <leader>yp :ServerCPara<Space>
]]

print("Minimal general functions loaded")
