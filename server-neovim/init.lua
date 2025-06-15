-- Set leader and localleader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Load core configurations
require('my-utils') -- General utility functions (loaded first if others depend on it)
require('options')   -- Basic Neovim options
require('packer-plugins') -- Plugin list and Packer setup

-- Load plugin-specific configurations
require('plugin-configs') -- Configurations for plugins like lualine, bufferline, etc.

-- Load core functionalities
require('core-files') -- File navigation, FZF, NvimTree setup and keymaps
require('core-git')   -- Git integration, gitsigns, fugitive keymaps
require('functions')  -- General custom functions

-- Load key Mappings
require('keymaps')   -- General key mappings (should be loaded after plugins if mappings depend on them)

-- Setup WhichKey
require("which-key").setup{}

-- Setup Colorscheme (Onedark)
local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then
  vim.notify("Onedark colorscheme not found!", vim.log.levels.WARN)
else
  onedark.setup({
    comment_style = "italic",
    overrides = function(c)
      return {
        MatchParen = { fg = c.cyan0, bg = c.bg_visual, style = "bold " }
      }
    end,
    colors = {
      bg_visual = '#5c6370'
    }
  })
  vim.cmd[[colorscheme onedark]]
end

-- Ensure Packer is installed and plugins are synced
local packer_bootstrap = false
local protect_packer = pcall(function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
  end
  
  local packer_ok, packer = pcall(require, 'packer')
  if packer_ok then
    packer.init({
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    })
    if packer_bootstrap then
      print 'Packer cloned successfully. Restart Neovim and run PackerSync.'
      packer.sync() -- Auto run PackerSync if bootstrap happened
    end
  else
    vim.notify("Packer not found or failed to load!", vim.log.levels.ERROR)
  end
end)

if not protect_packer then
    vim.notify("Error running Packer setup from init.lua", vim.log.levels.ERROR)
end

print("Minimal Neovim configuration loaded!")
