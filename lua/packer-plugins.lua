return require('packer').startup({
  function()
    use 'wbthomason/packer.nvim'

    use "folke/which-key.nvim"
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- use 'nvim-telescope/telescope.nvim'

    use  { 'junegunn/fzf', run = './install --bin'}
    use 'junegunn/fzf.vim'
    use 'ibhagwan/fzf-lua'
    use 'francoiscabrol/ranger.vim'

    use 'stsewd/fzf-checkout.vim'
    use 'tpope/vim-fugitive'
    use 'NeogitOrg/neogit'
    use 'lewis6991/gitsigns.nvim'
    use 'junegunn/gv.vim'
    use 'rhysd/conflict-marker.vim'
    use 'salcode/vim-interactive-rebase-reverse'
    use 'rhysd/git-messenger.vim'
    use 'sindrets/diffview.nvim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'HiPhish/rainbow-delimiters.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind-nvim'
    use 'folke/trouble.nvim'
    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    use 'quangnguyen30192/cmp-nvim-tags'
    use "rafamadriz/friendly-snippets"
    use 'windwp/nvim-ts-autotag'

    -- use 'neoclide/coc.nvim', {'branch': 'release'}
    use 'vmchale/dhall-vim'
    -- use 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
    use 'LnL7/vim-nix'
    -- use 'monkoose/fzf-hoogle.vim'
    use 'purescript-contrib/purescript-vim'
    use 'mtdl9/vim-log-highlighting'
    use 'octol/vim-cpp-enhanced-highlight'
    use 'maxmellon/vim-jsx-pretty'
    use 'pangloss/vim-javascript'
    use 'leafgarland/typescript-vim'
    use 'rescript-lang/vim-rescript'
    use 'nkrkv/nvim-treesitter-rescript'

    use 'rbgrouleff/bclose.vim'
    use 'kylechui/nvim-surround'
    use 'tpope/vim-abolish'
    use 'jiangmiao/auto-pairs'
    use 'godlygeek/tabular' -- "useful to line up text.
    use 'editorconfig/editorconfig-vim'
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use 'mhinz/vim-startify'
    use 'tpope/vim-obsession'
    use 'unblevable/quick-scope'
    use 'mbbill/undotree'
    use 'kristijanhusak/vim-carbon-now-sh'
    use 'junegunn/vim-slash' -- "  enhancing in-buffer searc
    use 'sunaku/tmux-navigate'
    use 'szw/vim-maximizer'
    use 'romainl/vim-qf'
    use 'windwp/nvim-spectre'

    use 'mtth/scratch.vim'
    use 'aserebryakov/vim-todo-lists'
    use({
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        -- requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
        -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
        -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
        config = function()
            require('render-markdown').setup({})
        end,
    })

   -- " use 'vim-airline/vim-airline'
    --" use 'vim-airline/vim-airline-themes'
    --" use 'ryanoasis/vim-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'Rigellute/shades-of-purple.vim'
    use 'kyoz/purify'

    use 'pseewald/vim-anyfold'
    use 'lifepillar/vim-gruvbox8'
    use 'crusoexia/vim-monokai'
    use 'ful1e5/onedark.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'
    use 'azabiong/vim-board'
    use 'akinsho/bufferline.nvim'
    use 'rcarriga/nvim-notify'
    use "folke/zen-mode.nvim"
    use "shortcuts/no-neck-pain.nvim"
    use 'p00f/nvim-ts-rainbow'
    -- use 'neovimhaskell/haskell-vim'
    -- use 'sotte/presenting.vim'

    use 'shivamashtikar/tmuxjump.vim'


    -- colorscheme
    use 'gruvbox-community/gruvbox'

  end,
  config = {
    max_jobs = 10
  }
})
