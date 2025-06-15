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

opt.clipboard = "unnamedplus" -- Works if server has clipboard utilities like xclip/xsel
opt.path = opt.path + "**" -- Path current directory and sub folders
opt.autowrite = true -- Buffer management
opt.autoread = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true -- Enable background buffers
opt.mouse= "a"
opt.modelines=0 -- Turn off modelines
opt.linebreak = true --Avoid wrapping a line in the middle of a word
opt.colorcolumn="100"
opt.formatoptions= "cqrn1"
opt.tabstop=2
opt.shiftwidth=2
opt.softtabstop=2
opt.expandtab = true
opt.scrolloff=5 -- Display 5 lines above/below the cursor when scrolling.
opt.ttyfast = true -- Speed up scrolling in Vim
opt.laststatus=3 -- Global statusline
opt.cursorline = true --Highlight the line currently under cursor.
-- opt.cursorcolumn = true -- Highlight current column (can be distracting)
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
opt.undofile = true
opt.confirm = true --Display a confirmation dialog when closing an unsaved file.
opt.updatetime=300 -- For plugins that update based on timers (e.g., gitsigns)
opt.showmode = true -- Display options
opt.showcmd = true
opt.list = true -- Display different types of white spaces.
opt.listchars = "tab:› ,trail:•,extends:#,nbsp:."
opt.encoding= "utf-8"-- Encoding
opt.hlsearch = true -- Highlight matching search patterns
opt.incsearch = true -- Enable incremental search

-- Fix splitting
opt.splitbelow = true
opt.splitright = true

opt.virtualedit="block" -- Allow cursor to go where there is no text in visual block mode

-- automatically rebalance windows on vim resize
cmd[[ autocmd VimResized * :wincmd = ]]

-- For scratch buffer
vim.g.scratch_persistence_file = vim.fn.stdpath('data') .. '/scratch_buffer'

-- Large file handling
cmd[[
augroup LargeFileMinimal
  autocmd!
  let g:large_file_minimal = 10485760 " 10MB "
  " Set options:
  "   eventignore+=FileType (no syntax highlighting etc
  "   assumes FileType always on)
  "   noswapfile (save copy of file)
  "   bufhidden=unload (save memory when other file is viewed)
  "   buftype=nowritefile (is read-only)
  "   undolevels=-1 (no undo possible)
  au BufReadPre *
        \ let f=expand("<afile>") |
        \ if getfsize(f) > g:large_file_minimal |
                \ set eventignore+=FileType |
                \ setlocal noswapfile bufhidden=unload undolevels=-1 |
        \ else |
                \ set eventignore-=FileType |
        \ endif
augroup END
]]

-- Ensure undodir exists
local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true
