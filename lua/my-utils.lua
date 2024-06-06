local notify = require('notify')
local opt_n = { noremap = true }
local api = vim.api
local wk = require("which-key")

local exports = {}

exports.printTable = function (table )
  print(tostring(table) .. '\n')
  for index, value in pairs(table) do
    print('    ' .. tostring(index) .. ' : ' .. tostring(value) .. '\n')
  end
end

exports.notifyOutput = function(command, opts)
  local output = ""
  local cmd = " $ " .. table.concat(command, " ");
  local notification
  notify(cmd, "info", vim.tbl_extend("keep", opts or {},  { title = " Executing Command" }))
  local lnotify = function(msg, level)
    local notify_opts = vim.tbl_extend(
      "keep",
      opts or {},
      { title = cmd , replace = notification }
    )
    notification = notify(msg, level, notify_opts)
  end
  local on_data = function(_, data)
    output = output .. table.concat(data, "\n")
    lnotify(output, "info")
  end
  vim.fn.jobstart(command, {
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        lnotify("Success!", "info")
      end
    end,
  })
end

exports.nmap = function(key, value, m)
  local mode = 'n'
  if m then
    mode = m
  end
  api.nvim_set_keymap(mode, key, value, opt_n)
end

exports.wkreg = function (obj)
  wk.register(obj, { prefix = "<leader>" })
end

exports.syscmd = function (obj, opt)
  return function ()
    exports.notifyOutput(obj, opt)
  end
end

exports.quickGS = function ()
  local output = vim.fn.system("git status")
  if not string.find(output,"fatal: not a git repository ") then
    local level = vim.log.levels.INFO
    if string.find(output, "Unmerged paths") then
      level = vim.log.levels.ERROR
    elseif string.find(output, "Changes not staged") or string.find(output, "Changes to be committed") then
      level = vim.log.levels.WARN
    end
    notify(output, level, { title = " git status" })
  end
end

-- Sample usage
-- set_ft_option({'c', 'c++'}, 'commentstring', '# %s')
exports.set_ft_option = function (ft, option, value)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    group = vim.api.nvim_create_augroup('FtOptions', {}),
    desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
    callback = function()
      vim.opt_local[option] = value
    end
  })
end

return exports
