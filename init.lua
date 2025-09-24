-- require('packer-plugins')
require('config.lazy')


-- local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands
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


-- require("notify-scripts")
