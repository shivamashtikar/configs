return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Core Dependencies
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- UI & Navigation
  use 'folke/which-key.nvim'
  use { 'junegunn/fzf', run = './install --bin' } -- FZF binary
  use 'ibhagwan/fzf-lua' -- Lua interface for FZF
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons' -- Icons for nvim-tree, lualine, etc.
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'akinsho/bufferline.nvim' -- Buffer tabs
  use 'mhinz/vim-startify' -- Start screen
  use 'tpope/vim-obsession' -- Session management
  use 'rcarriga/nvim-notify' -- Notifications

  -- Git Integration
  use 'tpope/vim-fugitive' -- Git wrapper
  use 'lewis6991/gitsigns.nvim' -- Git signs, blame, etc.
  use 'stsewd/fzf-checkout.vim' -- Checkout Git branches with FZF (vimscript based, works with fzf)
  use 'rhysd/conflict-marker.vim' -- Highlight and resolve merge conflicts
  use 'sindrets/diffview.nvim' -- Enhanced diff viewing

  -- Editing Enhancements
  use 'kylechui/nvim-surround' -- Manage surroundings (quotes, brackets)
  use {
    'numToStr/Comment.nvim', -- Easy code commenting
    config = function() require('Comment').setup() end
  }
  use 'jiangmiao/auto-pairs' -- Automatic pairing of brackets, quotes
  use 'mbbill/undotree' -- Visualize and navigate undo history
  use 'junegunn/vim-slash' -- Improved in-buffer search
  use 'windwp/nvim-spectre' -- Project-wide search and replace
  use 'rbgrouleff/bclose.vim' -- Improved buffer closing
  use 'editorconfig/editorconfig-vim' -- .editorconfig support
  use 'unblevable/quick-scope' -- Highlights for f/F/t/T motions
  use 'szw/vim-maximizer' -- Maximize current Neovim split
  use 'romainl/vim-qf' -- Enhancements for quickfix list
  use 'mtth/scratch.vim' -- Scratch buffer

  -- Theme
  use 'ful1e5/onedark.nvim' -- Your chosen colorscheme

  -- Tmux Integration (if tmux is used)
  use 'sunaku/tmux-navigate' -- Seamless navigation between Neovim splits and tmux panes
  use 'shivamashtikar/tmuxjump.vim' -- Tmux jump integration (ensure this plugin is accessible)

  if vim.fn.has('nvim-0.8') == 1 then
    require('packer').add{-- If you want to use a version of packer that queries git during startup
      'wbthomason/packer.nvim', commit = 'HEAD',
      config = function()
        vim.cmd([[packadd packer.nvim]])
      end,
    }
  end

end)
