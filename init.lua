require('packer-plugins')

require("which-key").setup{}

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands
require("onedark").setup({
   comment_style = "italic",
  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      MatchParen = { fg = c.cyan0, bg = c.bg_visual, style = "bold "}
    }
  end,
  colors = {
    bg_visual =  '#5c6370'
  }
})
cmd[[colorscheme onedark]]

require('options')
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
