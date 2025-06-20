local u = require('my-utils')
local wk = require("which-key")
local nmap = u.nmap

nmap(';', ':')
nmap(':', ';')
nmap('<leader><TAB>', ':b#<CR>')

-- Use alt + hjkl split navigation
nmap("<m-h>", "<c-w>h")
nmap("<m-j>", "<c-w>j")
nmap("<m-k>", "<c-w>k")
nmap("<m-l>", "<c-w>l")

-- ======== resize ========
-- Shortcut ctrl + hjkl for to resize windows
nmap('<C-j>', ': resize -2<CR>')
nmap('<C-k>', ': resize +2<CR>')
nmap('<C-h>', ': vertical resize -2<CR>')
nmap('<C-l>', ': vertical resize +2<CR>')

nmap('<leader>tb', ':wincmd =<cr>') -- window equal size
nmap('<leader>tt', ':MaximizerToggle<cr>')
nmap('<leader>tw', '<C-w>T') -- break out window to new tab
-- Change split orientation
nmap('<leader>ts', '<C-w>K') -- change vertical to horizontal
nmap('<leader>tv', '<C-w>H') -- change horizontal to vertical

nmap('<C-f>', 'J')
nmap('J', '<c-d>zz')
nmap('K', '<c-u>zz')

nmap('<M-BS>', '<C-w>', 'i')
-- Map Esc to kk
nmap('jk', '<Esc>', 'i')

nmap('>', '>gv', 'v')
nmap('<', '<gv', 'v')

-- ======== quit ========
-- Alias write and quit to Q
wk.add({
  {'<leader>q', group= '+quit'},
  {'<leader>qa', ':qa<cr>', desc='Quit all window' },
  {'<leader>qu', ':Bclose!<cr>', desc='Quit buffer unsaved' },
  {'<leader>qw', ':q<cr>', desc='Quit window' },
  {'<leader>qq', ':Bclose<cr>', desc='Quit buffer' },
  {'<leader>qo', '<C-w>o', desc='Close other window' },
  {'<leader>qf', group= '+QuickFix'},
  {'<leader>qfe', desc = '+Execute'},
  {'<leader>qfl', desc = '+Load' },
  {'<leader>qfs', desc = '+Save' },
})
nmap('<leader>qc', ':cexpr []<cr>')
nmap('<leader>qfd', ':Reject<SPace>')
nmap('<leader>qfll', ':LoadList<SPace>')
nmap('<leader>qfel', ':Doline<SPace>')
nmap('<leader>qfef', ':Dofile<SPace>')
nmap('<leader>qfla', ':LoadListAdd<SPace>')
nmap('<leader>qfk', ':Keep<space>')
nmap('<leader>qfq', ':FindList<SPace>')
nmap('<leader>qfr', ':Restore<CR>')
nmap('<leader>qfss', ':SaveList<SPace>')
nmap('<leader>qfsa', ':SaveListAdd<SPace>')

wk.add({ 
  {'<leader>w', ':up<CR>', desc='Write if changed' },
  {'<leader>b', group='+buffer' },
})

nmap('<Leader>bb', ':b <C-d>')
nmap('<Leader>bp', ':bprevious<CR>')
nmap('<Leader>bn', ':bnext<CR>')
nmap('<Leader>bf', ':bfirst<CR>')
nmap('<Leader>bl', ':blast<CR>')
nmap('<Leader>bk', ':bw<CR>')


-- ======== utilities ========
--
-- Shift + u for redo
nmap('<S-u>', '<C-r>')
nmap('<leader>p', '"_dP', 'x') -- paste widout updating register

nmap('<leader>ur', ':%s#<C-r><C-w>##g<Left><Left>')
nmap('<leader>ur', '"hy:%s#<C-r>h##gc<left><left><left>', 'v')
nmap('<leader>ud', 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
nmap('<leader>um', " :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")
-- Source Vim configuration file and install plugins
nmap('<leader>ui', ':source % | :PackerSync<CR>')
nmap('<leader>ua', ":argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>")

-- session
nmap('<Leader>us', ":exec ':Obsession ' . getcwd() . '/' . 'Session.vim'<CR>")
nmap('<Leader>uS', ':Obsession<CR>')

wk.add({
  {'<leader>u', group= '+Utilities'},
  {'<leader>ua', desc='Open file with partern'},
  {'<leader>ub', ':let &background =  &background == "dark" ? "light" : "dark" <CR>', desc='Background color toggle' },
  {'<leader>uc', ':FzfLua colorschemes <CR>', desc='ColorScheme' },
  {'<leader>ud', desc='Insert date time'},
  {'<leader>uf', ':FzfLua filetypes <CR>', desc='file types' },
  {'<leader>un',":g/^\\s*$/d<CR>", desc='delete empty newlines'},
  {'<leader>um', desc='Modify registers'},
  {'<leader>uj', ':%!jq .<cr>', desc='format json file' },
  {'<leader>ur', desc='Replace word'},
  {'<leader>uu', ':FzfLua commands <CR>', desc='Commands' },
  {'<leader>us', desc='Save Session'},
  {'<leader>uS', desc='Toggle Session'},
  {'<leader>ut', ':UndotreeToggle<cr>', desc='UndoTree' },
  {'<leader>uw', ':exec ":set foldlevel=0" | AnyFoldActivate <CR>', desc='Activate Fold' },
  {'<leader>uW', ':exec ":set foldlevel=99" <CR>', desc='UnFold all' },
})

-- Moving text
nmap('J', ":m '>+1<CR>gv=gv", 'v')
nmap('K', ":m '<-2<CR>gv=gv", 'v')
nmap('<C-k>', '<esc>:m .-2<CR>==i', 'i')
nmap('<C-j>', '<esc>:m .+1<CR>==i', 'i')

-- TmuxJump
-- jump to file with position using filepath from sibling panes in tmux
-- Requires fzf
nmap('<leader>ft', ':TmuxJumpFile<CR>')
nmap('<leader>;', ':TmuxJumpFirst<CR>')

-- nvim-spectre
wk.add({
  {'<leader>s', group= '+Spectre'},
  {'<leader>sc', desc='input replace cmd'},
  {'<leader>sm', desc='chage result view mode'},
  {'<leader>so', desc='Option menu'},
  {'<leader>sp', desc='Search in current file'},
  {'<leader>sq', desc='Send to QuickFix'},
  {'<leader>sr', desc='Replace'},
  {'<leader>ss', desc='Open'},
  {'<leader>sv', desc='Open Visual'},
  {'<leader>sw', desc='Search current word'},
})
nmap('<leader>ss', '<cmd>lua require("spectre").open()<CR>')
nmap('<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>') --"search current word
nmap('<leader>sv', '<cmd>lua require("spectre").open_visual()<CR>', 'v')
nmap('<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>') -- "  search in current file

nmap('<leader>n', ':silent! NoNeckPain<CR>')
