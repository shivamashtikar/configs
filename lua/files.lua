local u = require('my-utils')
local wk = require("which-key")
local nmap = u.nmap
-- --column: Show column number
-- --line-number: Show line number
-- --no-heading: Do not show file headings in results
-- --fixed-strings: Search term as a literal string
-- --ignore-case: Case insensitive search
-- --no-ignore: Do not respect .gitignore, etc...
-- --hidden: Search hidden files and folders
-- --follow: Follow symlinks
-- --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
-- --color: Search color options
vim.cmd[[
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindAll call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
function FindList(expr) abort
  exec ':Find '.a:expr
  call timer_start(1000, { tid -> feedkeys("\<M-a>\<CR>")})
endfunction

command -nargs=1 FindList call FindList(<f-args>)

function PFiles() abort
  if fugitive#Head() == ''
    FzfLua files
  else
    FzfLua git_files
  endif
endfunction
]]

vim.g.rg_grep_all = '--column --line-number --no-heading --fixed-strings --no-ignore --ignore-case --hidden --follow --glob "!.git/*" -g "!node_modules" --color "always"'
wk.add({
  mode ={"n"},
  {'<leader>o',  ':FzfLua buffers<cr>' , desc='Show Open buffers' },
  {'<leader>O',  ':FzfLua tabs<cr>' , desc='Show Open Windows'},
  {'<leader>r', ':lua require("ranger-nvim").open(true)<cr>'  , desc='Ranger'},
  {'<leader>f', group='+file'},
  {'<leader>fb', ':FzfLua btags<cr>', desc='current buffer tags' },
  {'<leader>fc', ':FzfLua jumps<cr>', desc='Jumps' },
  {'<leader>fe', ':FzfLua git_status<cr>', desc='Modified Files' },
  {'<leader>ff', ':call PFiles()<cr>', desc='Project files' },
  {'<leader>fF', ':FzfLua files<cr>', desc='Files' },
  {'<leader>fg', ':FzfLua live_grep<cr>', desc='Live Grep' },
  {'<leader>fj', ':FzfLua grep_cword<cr>', desc='grep_cword' },
  {'<leader>fl', ':FzfLua lines<cr>', desc='Find in current buffer' },
  {'<leader>fm', ':FzfLua marks<cr>', desc='marks' },
  {'<leader>fM', ':Maps<cr>', desc='normal maps' },
  {'<leader>fr', ':FzfLua resume<cr>', desc='Resume last fzf cmd' },
  {'<leader>fs', ':FzfLua grep<cr>', desc='Find' },
  {'<leader>fT', ':FzfLua tags<cr>', desc='project tags' },
  {'<leader>fz', ':FzfLua<cr>', desc='FZF' },
  {'<leader>fh', group='+h'},
  {'<leader>fhc', ':FzfLua command_history<cr>', desc='command history' },
  {'<leader>fhh', ':FzfLua help_tags <cr>', desc='help tags' },
  {'<leader>fhs', ':FzfLua search_history<cr>', desc='search history' },
  {'<leader>fhf', ':FzfLua oldfiles<cr>', desc='Previously open files' },
  {'<leader>fG', ':lua require("fzf-lua").live_grep({ rg_opts = vim.g.rg_grep_all })<CR>', group= 'Live Grep all'},
  {'<leader>fJ', ':lua require("fzf-lua").grep_cword({ rg_opts = vim.g.rg_grep_all })<CR>', group= 'Grep cword all'},
  {'<leader>fS', ':lua require("fzf-lua").grep({ rg_opts = vim.g.rg_grep_all })<CR>', group='Grep'},
})

nmap('<leader><space>',':NvimTreeToggle<CR>')
