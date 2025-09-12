local u = require('my-utils')
local nmap = u.nmap

local last_buf = nil

vim.api.nvim_set_keymap('n', '<leader><space>', '', {
  noremap = true,
  silent = true,
  callback = function()
    local api = vim.api
    local cur_buf = api.nvim_get_current_buf()
    local buf_name = api.nvim_buf_get_name(cur_buf)

    -- Check if current buffer is netrw (Explore)
    if buf_name:match("netrw://") then
      -- Close current (Explore) buffer
      vim.cmd('bd!')  -- wipe out the buffer to close Explore
      -- Switch back to last buffer if valid
      if last_buf and api.nvim_buf_is_valid(last_buf) then
        api.nvim_set_current_buf(last_buf)
      end
      last_buf = nil
    else
      -- Save current buffer, then open Explore in a new buffer
      last_buf = cur_buf
      vim.cmd('Explore')
    end
  end,
})


nmap('<leader>ff', ':find ')
