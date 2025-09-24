require('packer-plugins')

require("which-key").setup{}

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands
require('onedark').load()
require('options')
require('autocmds')
require('keymaps')
require('lsp-config')
require('git')
require('files')
require('language-keymaps')
require('rescript')
require('functions')
require('filetype')


require("nvim-tree").setup()
-- require("notify-scripts")
