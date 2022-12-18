local u = require('my-utils')
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
u.wkreg({
  q = {
    name = '+quit',
    a = { ':qa<cr>', 'Quit all window' },
    u = { ':Bclose!<cr>', 'Quit buffer unsaved' },
    w = { ':q<cr>', 'Quit window' },
    q = { ':Bclose<cr>', 'Quit buffer' },
    o = { '<C-w>o', 'Close other window' },
    f = {
      name = '+QuickFix',
      e = { name = '+Execute', },
      l = { name = '+Load', },
      s = { name = '+Save', },
    },
  } })
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

u.wkreg({ w = { ':up<CR>', 'Write if changed' } })

-- B commands
u.wkreg({ b = { name = '+buffer' } })
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

nmap('<leader>ur', ':%s/<C-r><C-w>//g<Left><Left>')
nmap('<leader>ur', '"hy:%s/<C-r>h//gc<left><left><left>', 'v')
nmap('<leader>ud', 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
nmap('<leader>um', " :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")
-- Source Vim configuration file and install plugins
nmap('<leader>ui', ':source % | :PackerSync<CR>')
nmap('<leader>ua', ":argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>")

-- session
nmap('<Leader>us', ":exec ':Obsession ' . getcwd() . '/' . 'Session.vim'<CR>")
nmap('<Leader>ut', ':Obsession<CR>')

u.wkreg({
  u = {
    name = '+Utilities',
    a = 'Open file with partern',
    b = { ':let &background =  &background == "dark" ? "light" : "dark" <CR>', 'Background color toggle' },
    c = { ':FzfLua colorschemes <CR>', 'ColorScheme' },
    d = 'Insert date time',
    f = { ':FzfLua filetypes <CR>', 'file types' },
    n = {":g/^\\s*$/d<CR>", 'delete empty newlines'},
    m = 'Modify registers',
    r = 'Replace word',
    u = { ':FzfLua commands <CR>', 'Commands' },
    s = 'Save Session',
    t = 'Toggle Session',
    w = { ':exec ":set foldlevel=0" | AnyFoldActivate <CR>', 'Activate Fold' },
    W = { ':exec ":set foldlevel=99" <CR>', 'UnFold all' },
  }
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
u.wkreg({
  s = {
    name = '+Spectre',
    c = 'input replace cmd',
    m = 'chage result view mode',
    o = 'Option menu',
    p = 'Search in current file',
    q = 'Send to QuickFix',
    r = 'Replace',
    s = 'Open',
    v = 'Open Visual',
    w = 'Search current word',
  } })
nmap('<leader>ss', '<cmd>lua require("spectre").open()<CR>')
nmap('<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>') --"search current word
nmap('<leader>sv', '<cmd>lua require("spectre").open_visual()<CR>', 'v')
nmap('<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>') -- "  search in current file

