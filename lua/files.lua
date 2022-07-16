local api = vim.api
local opt_n = { noremap = true }
local cmd = vim.cmd -- execute Vim commands
local wk = require("which-key")

local function nmap(key, value, m)
  local mode = 'n'
  if m then
    mode = m
  end
  api.nvim_set_keymap(mode, key, value, opt_n)
end

local function wkreg(obj)
  wk.register(obj, { prefix = "<leader>" })
end
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
nmap('<leader>fG', ':lua require("fzf-lua").live_grep({ rg_opts = vim.g.rg_grep_all })<CR>')
nmap('<leader>fJ', ':lua require("fzf-lua").grep_cword({ rg_opts = vim.g.rg_grep_all })<CR>')
nmap('<leader>fS', ':lua require("fzf-lua").grep({ rg_opts = vim.g.rg_grep_all })<CR>')

wkreg({
  o = { ':FzfLua buffers<cr>' , 'Show Open buffers' },
  p = { ':FzfLua tabs<cr>' , 'Show Open Windows' },
  r = {':Ranger<cr>'  , 'Ranger'},
  f = {
    name = '+file',
    b = { ':FzfLua btags<cr>', 'current buffer tags' },
    c = { ':FzfLua jumps<cr>', 'Jumps' },
    e = { ':FzfLua git_status<cr>', 'Modified Files' },
    f = { ':call PFiles()<cr>', 'Project files' },
    --f = { ':FzfLua git_files<cr>', 'Project files' },
    F = { ':FzfLua files<cr>', 'Files' },
    g = { ':FzfLua live_grep<cr>', 'Live Grep' },
    G = 'Live Grep all',
    h = {
      name = '+H',
      c = { ':FzfLua command_history<cr>', 'command history' },
      h = { ':FzfLua help_tags <cr>', 'help tags' },
      s = { ':FzfLua search_history<cr>', 'search history' },
      f = { ':FzfLua oldfiles<cr>', 'Previously open files' },
    },
    j = { ':FzfLua grep_cword<cr>', 'grep_cword' },
    J = 'Grep cword all',
    l = { ':FzfLua lines<cr>', 'Find in current buffer' },
    m = { ':FzfLua marks<cr>', 'marks' },
    M = { ':Maps<cr>', 'normal maps' },
    r = { ':FzfLua resume<cr>', 'Resume last fzf cmd' },
    s = { ':FzfLua grep<cr>', 'Find' },
    T = { ':FzfLua tags<cr>', 'project tags' },
    z = { ':FzfLua<cr>', 'FZF' },
  },
})

nmap('<leader><space>',':NvimTreeToggle<CR>')
