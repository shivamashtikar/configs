local u = require('my-utils')
local nmap = u.nmap

vim.api.nvim_set_keymap('n', '<leader><space>', '', {
  noremap = true,
  silent = true,
  callback = function()
    local api = vim.api

    local netrw_win = nil
    for _, win in ipairs(api.nvim_list_wins()) do
      local buf_name = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
      if buf_name:match("netrw://") then
        netrw_win = win
        break
      end
    end

    if netrw_win then
      api.nvim_win_close(netrw_win, true)
      vim.cmd('b#')
    else
      vim.cmd('Explore')
    end
  end,
})


nmap('<leader>ff', ':find ')
