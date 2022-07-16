vim.g.startify_change_to_dir = 0
vim.g.startify_session_autoload = 1
vim.g.startify_session_sort = 1
vim.g.startify_change_to_vcs_root = 1
vim.cmd[[
let g:startify_lists = [
\ { 'type': 'sessions'  , 'header': ['   Sessions'                     ] } ,
\ { 'type': 'files'     , 'header': ['   Files'                        ] } ,
\ { 'type': 'dir'       , 'header': ['   Current Directory '. getcwd() ] } ,
\ { 'type': 'bookmarks' , 'header': ['   Bookmarks'                    ] } ,
\ ]
]]
