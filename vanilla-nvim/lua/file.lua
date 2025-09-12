local u = require('my-utils')
local nmap = u.nmap

local last_buf = nil

vim.api.nvim_set_keymap('n', '<leader><space>', '', {
  noremap = true,
  silent = true,
  callback = function()
    local api = vim.api

    -- Find netrw window if open
    local netrw_win = nil
    for _, win in ipairs(api.nvim_list_wins()) do
      local buf_name = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
      if buf_name:match("netrw://") then
        netrw_win = win
        break
      end
    end

    if netrw_win then
      -- Close netrw window
      api.nvim_win_close(netrw_win, true)
      -- Switch back to the buffer we stored last time
      if last_buf and api.nvim_buf_is_valid(last_buf) then
        api.nvim_set_current_buf(last_buf)
      end
      last_buf = nil
    else
      -- Store current buffer before opening Explore
      last_buf = api.nvim_get_current_buf()
      -- Open Explore window
      vim.cmd('Explore')
    end
  end,
})


nmap('<leader>ff', ':find ')
