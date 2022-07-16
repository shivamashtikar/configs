require('packer-plugins')

require("which-key").setup{}

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands
local g = vim.g -- global variables


cmd[[colorscheme onedark]]

require('options')
require('keymaps')
require('lsp-config')
require('git')
require('files')
require('purescript')
require('functions')


require("nvim-tree").setup()

