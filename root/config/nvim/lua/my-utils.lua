local api = vim.api
local exports = {}
local opt_n = { noremap = true }
exports.nmap = function(key, value, m)
  local mode = 'n'
  if m then
    mode = m
  end
  api.nvim_set_keymap(mode, key, value, opt_n)
end

return exports
