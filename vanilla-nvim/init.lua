vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands
cmd[[colorscheme slate]]

require('options')
require('autocmds')
require('keymaps')

