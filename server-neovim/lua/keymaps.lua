local u = require('my-utils')
local wk = require("which-key") -- Ensure which-key is required here or in init.lua before setup
local nmap = u.nmap

-- Basic remappings
nmap(';', ':')
nmap(':', ';')
nmap('<leader><TAB>', ':b#<CR>') -- Switch to previous buffer

-- Window navigation
nmap("<m-h>", "<c-w>h")
nmap("<m-j>", "<c-w>j")
nmap("<m-k>", "<c-w>k")
nmap("<m-l>", "<c-w>l")

-- Window resizing
nmap('<C-j>', ':resize -2<CR>')
nmap('<C-k>', ':resize +2<CR>')
nmap('<C-h>', ':vertical resize -2<CR>')
nmap('<C-l>', ':vertical resize +2<CR>')

-- Window management
wk.register({
    ['<leader>t'] = { name = '+tabs/windows' },
    ['<leader>tb'] = { ':wincmd =<cr>', 'Balance window sizes' },
    ['<leader>tt'] = { ':MaximizerToggle<cr>', 'Toggle maximize window' },
    ['<leader>tw'] = { '<C-w>T', 'Move window to new tab' },
    ['<leader>ts'] = { '<C-w>K', 'Split horizontal from vertical' },
    ['<leader>tv'] = { '<C-w>H', 'Split vertical from horizontal' },
}, { prefix = "" })


-- Movement and editing
nmap('<C-f>', 'J') -- Join line
nmap('J', '<c-d>zz') -- Scroll down half page and center
nmap('K', '<c-u>zz') -- Scroll up half page and center

nmap('<M-BS>', '<C-w>', {mode = 'i'}) -- Delete word backwards in insert mode
nmap('jk', '<Esc>', {mode = 'i'}) -- jk to Escape in insert mode

nmap('>', '>gv', {mode = 'v'}) -- Indent visual selection
nmap('<', '<gv', {mode = 'v'}) -- Unindent visual selection

-- Quit and Buffer management
wk.register({
    ['<leader>q'] = { name = '+quit/close' },
    ['<leader>qa'] = { ':qa<cr>', 'Quit All' },
    ['<leader>qu'] = { ':Bclose!<cr>', 'Close Buffer (force)' },
    ['<leader>qw'] = { ':q<cr>', 'Quit Window' },
    ['<leader>qq'] = { ':Bclose<cr>', 'Close Buffer' },
    ['<leader>qo'] = { '<C-w>o', 'Close Other Windows' },

    ['<leader>w'] = { ':up<CR>', 'Write if changed' },

    ['<leader>b'] = { name = '+buffers' },
    ['<leader>bb'] = { ':b <C-d>', 'Switch buffer (complete)' }, -- Needs fzf-lua or similar for <C-d>
    ['<leader>bp'] = { ':bprevious<CR>', 'Previous Buffer' },
    ['<leader>bn'] = { ':bnext<CR>', 'Next Buffer' },
    ['<leader>bf'] = { ':bfirst<CR>', 'First Buffer' },
    ['<leader>bl'] = { ':blast<CR>', 'Last Buffer' },
    ['<leader>bk'] = { ':bw<CR>', 'Wipeout Buffer (close)' }, -- Consider if Bclose is preferred
}, { prefix = "" })


-- Utilities
nmap('<S-u>', '<C-r>') -- Shift+U for redo
nmap('<leader>p', '"_dP', {mode = 'x'}) -- Paste without yanking selection

wk.register({
    ['<leader>u'] = { name = '+utilities' },
    ['<leader>ud'] = { 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>', 'Insert datetime' },
    ['<leader>ui'] = { ':source % | :PackerSync<CR>', 'Source current file & Sync Packer' },
    ['<leader>us'] = { ":execute ':Obsession ' . getcwd() . '/' . 'Session.vim'<CR>", 'Save Session Here' },
    ['<leader>uS'] = { ':Obsession<CR>', 'Load/Toggle Session' },
    ['<leader>ut'] = { ':UndotreeToggle<cr>', 'Toggle Undotree' },
    ['<leader>uc'] = { ':FzfLua colorschemes<CR>', 'Colorschemes (FZF)' },
    ['<leader>un'] = { ":g/^\\s*$/d<CR>", 'Delete empty lines' },
    ['<leader>uj'] = { ':%!jq .<cr>', 'Format JSON (jq)' }, -- Requires jq
}, { prefix = "" })

-- Moving text lines
nmap('J', ":m '>+1<CR>gv=gv", {mode = 'v'}) -- Move visual selection down
nmap('K', ":m '<-2<CR>gv=gv", {mode = 'v'}) -- Move visual selection up
nmap('<C-k>', '<esc>:m .-2<CR>==i', {mode = 'i'}) -- Move current line up in insert mode
nmap('<C-j>', '<esc>:m .+1<CR>==i', {mode = 'i'}) -- Move current line down in insert mode

-- TmuxJump (if tmux is used)
wk.register({
    ['<leader>f'] = { name = '+find/file (see files.lua for more)'}, -- Placeholder, actual fzf defined in files.lua
    ['<leader>ft'] = { ':TmuxJumpFile<CR>', 'Tmux Jump to File' },
    ['<leader>;'] = { ':TmuxJumpFirst<CR>', 'Tmux Jump First Match' },
}, { prefix = "" })


-- nvim-spectre (Search and Replace)
wk.register({
    ['<leader>s'] = { name = '+spectre (Search/Replace)' },
    ['<leader>ss'] = { '<cmd>lua require("spectre").open()<CR>', 'Open Spectre' },
    ['<leader>sw'] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', 'Search current word' },
    ['<leader>sp'] = { 'viw<cmd>lua require("spectre").open_file_search()<CR>', 'Search in current file (visual word)' },
    -- Mappings for sc, sm, so, sr, sq are in spectre's own config or can be added here if preferred
}, { prefix = "" })
nmap('<leader>sv', '<cmd>lua require("spectre").open_visual()<CR>', {mode = 'v'}) -- Spectre search visual selection

-- For quickfix list navigation (from romainl/vim-qf, if that's what you meant by qf plugin)
-- These are standard, but good to note if vim-qf enhances them.
-- nmap(']q', ':cnext<CR>')
-- nmap('[q', ':cprevious<CR>')
-- nmap(']Q', ':clast<CR>')
-- nmap('[Q', ':cfirst<CR>')

-- Which-key setup (usually in init.lua, but can be here if it's the main keymap file)
-- Ensure this is called after all wk.register calls
-- wk.setup {} -- This will be called in init.lua
