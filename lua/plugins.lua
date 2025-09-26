return {
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup {}
    end,
  },

  -- dependencies
  { "nvim-lua/plenary.nvim" },

  -- telescope
  { "nvim-telescope/telescope.nvim", cmd = "Telescope",                 dependencies = { "nvim-lua/plenary.nvim" } },

  -- fzf
  { "junegunn/fzf",                  build = "./install --bin" },
  { "junegunn/fzf.vim",              cmd = { "FZF", "Find", "FindAll" } },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("fzf-lua").setup {
        winopts = {
          fullscreen = true,
          preview = {
            vertical     = "up:60%",
            flip_columns = 100,
            horizontal   = "right:50%",
            layout       = "vertical"
          },
        },
        fzf_opts = {
          ["--layout"] = "default",
        },
        files = {
          rg_opts = "--color=never --files --hidden --follow --no-ignore -g '!\\.git'",
        }
      }
    end
  },

  -- ranger
  { "kelly-lin/ranger.nvim", },

  -- git
  { "stsewd/fzf-checkout.vim", cmd = "Checkout" },
  { "tpope/vim-fugitive" },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup {}
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
      }
    end,
  },
  { "junegunn/gv.vim",                        cmd = "GV" },
  {
    "rhysd/conflict-marker.vim",
    event = "BufReadPre",
    config = function()
      vim.g.conflict_marker_highlight_group = ""
      vim.g.conflict_marker_begin           = "^<<<<<<< .*$"
      vim.g.conflict_marker_end             = "^>>>>>>> .*$"
      vim.cmd [[
      highlight ConflictMarkerBegin guibg=#2f7366
      highlight ConflictMarkerOurs guibg=#2e5049
      highlight ConflictMarkerTheirs guibg=#344f69
      highlight ConflictMarkerEnd guibg=#2f628e
      highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
      ]]
    end
  },
  { "salcode/vim-interactive-rebase-reverse", event = "VeryLazy" },
  { "rhysd/git-messenger.vim",                cmd = "GitMessenger" },
  { "sindrets/diffview.nvim",                 cmd = "DiffviewOpen", dependencies = { "nvim-lua/plenary.nvim" } },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "c",
          "lua",
          "rust",
          "javascript",
          "typescript",
          "json",
          "bash",
          "haskell",
          "groovy",
          "cpp",
          "nix",
          "go",
          "markdown",
          "markdown_inline",
        },
      })
    end,
  },
  -- lsp, cmp
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp",               event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp",           dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-buffer",             dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-path",               dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-cmdline",            dependencies = "nvim-cmp" },
  { "L3MON4D3/LuaSnip",               event = "InsertEnter",           dependencies = "nvim-cmp" },
  { "saadparwaiz1/cmp_luasnip",       dependencies = "nvim-cmp" },
  { "onsails/lspkind-nvim" },
  { "folke/trouble.nvim",             cmd = "Trouble",                 dependencies = { "nvim-lua/plenary.nvim" } },
  { "quangnguyen30192/cmp-nvim-tags", dependencies = "nvim-cmp" },
  { "rafamadriz/friendly-snippets" },
  { "windwp/nvim-ts-autotag",         dependencies = "nvim-treesitter" },

  -- llm
  { "huggingface/llm.nvim",           event = "VeryLazy",              dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    config = function()
      require("gen").setup({
        host = os.getenv("OLLAMA_ENDPOINT") or "localhost",
        model = "devstral:24b",
        display_mode = "vertical-split",
        show_prompt = true,
        file = true,
        no_auto_cose = true
      })
    end
  },

  -- languages
  { "vmchale/dhall-vim",                ft = "dhall" },
  { "LnL7/vim-nix",                     ft = "nix" },
  { "mtdl9/vim-log-highlighting",       ft = "log" },
  { "octol/vim-cpp-enhanced-highlight", ft = { "c", "cpp" } },
  { "rescript-lang/vim-rescript",       ft = "rescript" },
  { "nkrkv/nvim-treesitter-rescript",   dependencies = "nvim-treesitter" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },


  -- utils
  { "rbgrouleff/bclose.vim", cmd = "Bclose" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  { "tpope/vim-abolish",     cmd = "Abolish" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'PmenuSel',
          highlight_grey = 'LineNr'
        },
      })
    end
  },
  { "godlygeek/tabular",            cmd = "Tabularize" },
  { "editorconfig/editorconfig-vim" },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end
  },
  {
    "mhinz/vim-startify",
    event = "VimEnter",
    config = function()
      vim.g.startify_change_to_dir = 0
      vim.g.startify_session_autoload = 1
      vim.g.startify_session_sort = 1
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_lists = {
        { type = 'sessions',  header = { '   Sessions' } },
        { type = 'files',     header = { '   Files' } },
        { type = 'dir',       header = { '   Current Directory ' .. vim.fn.getcwd() } },
        { type = 'bookmarks', header = { '   Bookmarks' } },
      }
    end
  },
  { "tpope/vim-obsession" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  { "mbbill/undotree",                  cmd = "UndotreeToggle" },
  { "kristijanhusak/vim-carbon-now-sh", cmd = "CarbonNowSh" },
  { "junegunn/vim-slash",               event = "VeryLazy" },
  { "sunaku/tmux-navigate" },
  { "szw/vim-maximizer",                cmd = "MaximizerToggle" },
  { "romainl/vim-qf",                   cmd = { "Reject", "LoadList", "Doline", "Dofile", "LoadListAdd", "Keep", "FindList", "Restore", "SaveList", "SaveListAdd" } },
  {
    "windwp/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({
        live_update = true,
        mapping = {
          ["send_to_qf"] = { map = "<leader>sq", cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>", desc = "send all item to quickfix" },
          ["replace_cmd"] = { map = "<leader>sc", cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>", desc = "input replace vim command" },
          ["show_option_menu"] = { map = "<leader>so", cmd = "<cmd>lua require('spectre').show_options()<CR>", desc = "show option" },
          ["run_replace"] = { map = "<leader>sr", cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>", desc = "replace all" },
          ["change_view_mode"] = { map = "<leader>sm", cmd = "<cmd>lua require('spectre').change_view()<CR>", desc = "change result view mode" },
        },
      })
    end
  },
  { "mtth/scratch.vim",                          cmd = "Scratch" },
  { "aserebryakov/vim-todo-lists",               event = "VeryLazy" },
  { "nvim-tree/nvim-web-devicons",               opts = {} },
  { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, opts = {}, },
  {
    'stevearc/conform.nvim',
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    }
  },

  -- ui
  { "norcalli/nvim-colorizer.lua",    event = "BufRead" },
  { "Rigellute/shades-of-purple.vim", lazy = true,            name = "shades-of-purple" },
  { "kyoz/purify",                    lazy = true },
  { "pseewald/vim-anyfold",           cmd = "AnyFoldActivate" },
  { "lifepillar/vim-gruvbox8",        lazy = true },
  { "crusoexia/vim-monokai",          lazy = true },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").load()
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        reload_on_bufenter = true,
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 45,
        },
        git = {
          enable = false,
          ignore = false
        }
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    event = "VeryLazy",
    opts = {
      theme = "onedark",
    }
  },
  { "j-hui/fidget.nvim" },
  { "azabiong/vim-board",      event = "VeryLazy" },
  { 'akinsho/bufferline.nvim', version = "*",     dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require("notify")
    end
  },
  { "folke/zen-mode.nvim",            cmd = "ZenMode" },
  { "shortcuts/no-neck-pain.nvim",    cmd = "NoNeckPain" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "psiska/telescope-hoogle.nvim",   ft = "haskell",      dependencies = "telescope.nvim" },
  { "shivamashtikar/tmuxjump.vim",    cmd = "TmuxJumpFile" },

  -- colorscheme
  { "gruvbox-community/gruvbox",      lazy = true },
}
