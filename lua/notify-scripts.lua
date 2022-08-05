local u = require('my-utils')

vim.api.nvim_create_autocmd(
  { "VimEnter" , "BufWinEnter"},
  { callback = u.quickGS
  , once = true
  }
)

