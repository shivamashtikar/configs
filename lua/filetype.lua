local u = require('my-utils')

vim.api.nvim_create_autocmd("FileType", {
  pattern = {'c', 'cpp'},
  group = vim.api.nvim_create_augroup('FtKeymap', {}),
  callback = function()
    u.nmap('<leader>c', ':!g++ % -o %.o && echo && %.o<CR>')
    -- u.nmap('<leader>c', '<ESC>:!g++ % -o %.o && echo && %.o<CR>', 'i')
  end
})
