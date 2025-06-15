local u = require('my-utils')
local wk = require("which-key")
local nmap = u.nmap
local cmd = vim.cmd

-- Configure nvim-tree
require('nvim-tree').setup {
  reload_on_bufenter = true,
  git = {
    enable = true, -- Show git status in nvim-tree
    ignore = false
  },
  view = {
    width = 30,
    side = 'left',
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = false, -- Show dotfiles
    custom = { ".git", "node_modules", ".cache" }, -- Hide these
  },
  actions = {
    open_file = {
      quit_on_open = false, -- Keep nvim-tree open when opening a file
    }
  }
}

-- Configure fzf-lua
require('fzf-lua').setup{
  winopts = {
    fullscreen = true,
    preview = {
      vertical = 'up:60%',
      flip_columns = 100,
      horizontal = 'right:50%',
      layout = "vertical"
    },
  },
  fzf_opts = {
    ['--layout'] = "default",
  },
  files = {
    -- Uses rg by default if available, otherwise find
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --follow -g '!{.git,node_modules,target}/*'",
    find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/target/*']],
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --follow -g '!{.git,node_modules,target}/*'",
  },
  git = {
    files = {
      cmd = "git ls-files --exclude-standard",
    },
    status = {
      cmd = "git status -s",
    },
  },
  buffers = {
    show_unloaded = true,
    sort_lastused = true,
  }
}

-- Custom rg commands for fzf.vim (if fzf.vim is also used or for direct command line use)
cmd[[
command! -bang -nargs=* FindRg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindRgAll call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

function! ServerFindList(expr) abort
  exec ':FindRg '.a:expr
  call timer_start(100, { tid -> feedkeys("\<M-a>\<CR>")}) " Shorter timer
endfunction
command! -nargs=1 FindRgList call ServerFindList(<f-args>)
]]

-- Function to intelligently choose fzf-lua git_files or files
cmd[[
function! ServerPFiles() abort
  if exists('*fugitive#Head') && fugitive#Head() != ''
    lua require('fzf-lua').git_files()
  else
    lua require('fzf-lua').files()
  endif
endfunction
]]

vim.g.rg_grep_all_minimal = '--column --line-number --no-heading --fixed-strings --no-ignore --ignore-case --hidden --follow --glob "!.git/*" -g "!node_modules" --color "always"'

-- File and buffer navigation keymaps
wk.register({
    ['<leader>o'] = { ':FzfLua buffers<cr>', 'FZF Buffers' },
    ['<leader>O'] = { ':FzfLua tabs<cr>', 'FZF Tabs (Windows)' }, -- Assuming tabs means editor tabs/windows

    ['<leader>f'] = { name = '+find/files (FZF)' },
    ['<leader>fb'] = { ':FzfLua btags<cr>', 'FZF Buffer Tags' },
    ['<leader>fc'] = { ':FzfLua jumps<cr>', 'FZF Jumplist' },
    ['<leader>fe'] = { ':FzfLua git_status<cr>', 'FZF Git Status (Modified files)' },
    ['<leader>ff'] = { ':call ServerPFiles()<cr>', 'FZF Project Files (Git aware)' },
    ['<leader>fF'] = { ':FzfLua files<cr>', 'FZF All Files' },
    ['<leader>fg'] = { ':FzfLua live_grep<cr>', 'FZF Live Grep (rg)' },
    ['<leader>fj'] = { ':FzfLua grep_cword<cr>', 'FZF Grep CWORD (rg)' },
    ['<leader>fl'] = { ':FzfLua lines<cr>', 'FZF Lines in Current Buffer' },
    ['<leader>fm'] = { ':FzfLua marks<cr>', 'FZF Marks' },
    ['<leader>fr'] = { ':FzfLua resume<cr>', 'FZF Resume Last Search' },
    ['<leader>fs'] = { ':FzfLua grep<cr>', 'FZF Grep (rg)' },
    -- ['<leader>fT'] = { ':FzfLua tags<cr>', 'FZF Project Tags' }, -- Tags might require ctags setup

    ['<leader>fh'] = { name = '+history (FZF)' },
    ['<leader>fhc'] = { ':FzfLua command_history<cr>', 'FZF Command History' },
    ['<leader>fhh'] = { ':FzfLua help_tags <cr>', 'FZF Help Tags' },
    ['<leader>fhs'] = { ':FzfLua search_history<cr>', 'FZF Search History' },
    ['<leader>fhf'] = { ':FzfLua oldfiles<cr>', 'FZF Old Files (History)' },

    -- Grep with slightly different rg options (e.g. no-ignore)
    ['<leader>fG'] = { ':lua require("fzf-lua").live_grep({ rg_opts = vim.g.rg_grep_all_minimal })<CR>', 'FZF Live Grep All' },
    ['<leader>fJ'] = { ':lua require("fzf-lua").grep_cword({ rg_opts = vim.g.rg_grep_all_minimal })<CR>', 'FZF Grep CWORD All' },
    ['<leader>fS'] = { ':lua require("fzf-lua").grep({ rg_opts = vim.g.rg_grep_all_minimal })<CR>', 'FZF Grep All' },

    ['<leader><space>'] = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
}, { prefix = "" })

print("Minimal Files/FZF config loaded")
