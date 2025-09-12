local u = require('my-utils')
local nmap = u.nmap

local function toggle_explore()
  local api = vim.api
  local bufnr = api.nvim_get_current_buf()
  local fn = vim.fn

  -- Check if a netrw buffer is already open in any window
  local netrw_win = nil
  for _, win in ipairs(api.nvim_list_wins()) do
    local win_bufnr = api.nvim_win_get_buf(win)
    local buf_name = api.nvim_buf_get_name(win_bufnr)
    -- Netrw buffers have "netrw://" in their name
    if buf_name:match("netrw://") then
      netrw_win = win
      break
    end
  end

  if netrw_win then
    -- netrw is open; close its window and return to previous buffer
    api.nvim_win_close(netrw_win, true)
    -- Switch back to previous buffer (last edited file)
    vim.cmd('b#')
  else
    -- netrw not open; open it
    vim.cmd('Explore')
  end
end

-- Map <leader><space> to toggle function in normal mode
nmap('<leader><space>', "<cmd>lua toggle_explore()<CR>")

nmap('<leader>ff', ':find ')
