local u = require('my-utils')
local nmap = u.nmap

nmap('<leader><space>',':Explore<CR>')
nmap('<leader>ff', ':files<CR>:find<Space>')
nmap('<leader>fe', ':buffers<CR>:buffer<Space>')
nmap('<leader>fc', ":argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>")
