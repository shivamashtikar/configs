local notify = require("notify")

vim.api.nvim_create_autocmd(
  { "VimEnter" , "BufWinEnter"},
  { callback = function ()
      -- print(vim.api.nvim_call_function("fugitive#Head",{}))
      -- notify(vim.api.nvim_call_function("fugitive#Head",{}))
      local output = vim.fn.system("git status")
      if not string.find(output,"fatal: not a git repository ") then
        local level = vim.log.levels.INFO
        if string.find(output, "Unmerged paths") then
          level = vim.log.levels.ERROR
        elseif string.find(output, "Changes not staged") or string.find(output, "Untracked files") then
          level = vim.log.levels.WARN
        end
        notify(output, level, { title = " git status" })
      end
    end
  , once = true
  }
)

