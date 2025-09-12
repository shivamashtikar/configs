local u = require('my-utils')
local nmap = u.nmap
local vmap = u.vmap
local nvmap = u.nvmap

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
nmap('<leader>qa', ':qa<cr>')
nmap('<leader>qc', ':cexpr []<cr>')
nmap('<leader>qo', '<C-w>o')
nmap('<leader>qq', '<cmd>bdelete<CR>')
nmap('<leader>qw', ':q<cr>')

nmap('<Leader>w', ':up<CR>')
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
nmap('<leader>un',":g/^\\s*$/d<CR>")
nmap('<leader>ub', ':let &background =  &background == "dark" ? "light" : "dark" <CR>')
nmap('<leader>uj', ':%!jq .<cr>')
nmap('<leader>uw', ':exec ":set foldlevel=0" | AnyFoldActivate <CR>')
nmap('<leader>uW', ':exec ":set foldlevel=99" <CR>')

-- Moving text
nmap('J', ":m '>+1<CR>gv=gv", 'v')
nmap('K', ":m '<-2<CR>gv=gv", 'v')
nmap('<C-k>', '<esc>:m .-2<CR>==i', 'i')
nmap('<C-j>', '<esc>:m .+1<CR>==i', 'i')

