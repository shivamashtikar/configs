-- Bufferline config
require("bufferline").setup{
  options = {
    -- diagnostics = "nvim_lsp", -- LSP removed
    tab_size = 12,
    offsets = {{
      filetype = "NvimTree",
      text = "File Explorer" ,
      highlight = "Directory",
      text_align = "left"
    }}
  }
}

-- Lualine config
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark', -- Make sure onedark theme is loaded before this
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'}, -- 'diagnostics' removed
    lualine_c = { {
      'filename' ,
      file_status = true ,
      path = 1
      }
      -- { 'lsp_progress' } -- LSP removed
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', file_status = true, path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {} -- Consider adding 'nvim-tree' extension if desired
}

-- Nvim Surround config
require("nvim-surround").setup()

-- Spectre config
require('spectre').setup({
  live_update = true
  -- Mappings are handled by the main keymaps.lua file
})

-- Startify config
vim.g.startify_change_to_dir = 0
vim.g.startify_session_autoload = 1
vim.g.startify_session_sort = 1
vim.g.startify_change_to_vcs_root = 1
vim.cmd[[
let g:startify_lists = [
\ { 'type': 'sessions'  , 'header': ['   Sessions'                     ] } ,
\ { 'type': 'files'     , 'header': ['   Recent Files'                 ] } ,
\ { 'type': 'dir'       , 'header': ['   Current Directory '. getcwd() ] } ,
\ { 'type': 'bookmarks' , 'header': ['   Bookmarks'                    ] } ,
\ ]
]]

print("Minimal plugin-specific configs loaded")
