local opt = vim.opt -- global/buffer/windows-scoped options
local cmd = vim.cmd -- execute Vim commands

opt.timeoutlen = 500
opt.number = true
opt.relativenumber = true
cmd[[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]]

opt.clipboard = "unnamedplus"
opt.path= opt.path +"**" -- Path current directory and sub folders
opt.autowrite = true -- Buffer management
opt.autoread = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hidden = true
opt.mouse= "a"
opt.modelines=0 -- Turn off modelines
opt.linebreak = true --Avoid wrapping a line in the middle of a word
opt.colorcolumn="100"
opt.formatoptions= "cqrn1"
opt.tabstop=2
opt.shiftwidth=2
opt.softtabstop=2
opt.expandtab = true
--opt.noshiftround = true
opt.scrolloff=5 -- Display 5 lines above/below the cursor when scrolling with a mouse.
-- opt.backspace= "indent,eol,start " -- Fixes common backspace problems
opt.ttyfast = true -- Speed up scrolling in Vim
opt.laststatus=3 -- Status bar
-- opt.winbar="%=%m %f"
opt.cursorline = true --Highlight the line currently under cursor.
-- opt.backupdir="~/.cache/vim" -- Directory to store backup files.h
opt.confirm = true --Display a confirmation dialog when closing an unsaved file.
opt.updatetime=300
opt.showmode = true -- Display options
opt.showcmd = true
-- opt.matchpairs= opt.matchpairs + "<:>" -- Highlight matching pairs of brackets. Use the '%' character to jump between them.
opt.list = true -- Display different types of white spaces.
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.encoding= "utf-8"-- Encoding
opt.hlsearch = true -- Highlight matching search patterns
opt.incsearch = true -- Enable incremental search
opt.ignorecase = true -- Include matching uppercase words with lowercase search term
opt.smartcase = true -- Include only uppercase words with uppercase search term
-- opt.viminfo='100,<9999,s100 -- Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
-- opt.completeopt=menu,menuone,noselect
-- omit a dir from all searches to perform globally
opt.wildignore = opt.wildignore + "**/node_modules/**"

-- Fix splitting
opt.splitbelow = true
opt.splitright = true

-- automatically rebalance windows on vim resize
cmd[[ autocmd VimResized * :wincmd = ]]
