local api = vim.api
local opt_n = { noremap = true }
local cmd = vim.cmd -- execute Vim commands
local wk = require("which-key")

local function nmap(key, value, m)
  local mode = 'n'
  if m then
    mode = m
  end
  api.nvim_set_keymap(mode, key, value, opt_n)
end

local function wkreg(obj)
  wk.register(obj, { prefix = "<leader>" })
end

cmd[[ 
function PrevAction() abort
  try
    exe ':cp'
  catch
    ConflictMarkerPrevHunk
    :silent! Gitsigns prev_hunk
  endtry
endfunction

function NextAction() abort
  try
    exe ':cn'
  catch
      ConflictMarkerNextHunk
      :silent! Gitsigns next_hunk
  endtry
endfunction
]]

nmap('<C-n>',':call NextAction()<CR>')
nmap('<C-p>',':call PrevAction()<CR>')

nmap('<leader>giq',':call GSquash()<CR>')
nmap('<leader>gin',':exe "Git push --set-upstream origin ". fugitive#Head()<CR>')
nmap('<leader>gig',':exe "Git reset --hard origin/". fugitive#Head()<CR>')
nmap('<leader>gij',':exe "normal! a" . matchstr(fugitive#Head(), "PICAF-[0-9]*"). " "<CR>a')
nmap('<leader>gpr',':Git pull --rebase origin/')
nmap('<leader>gpm',':Git pull --merge origin/')

wkreg({
  g = {
  name='+git'                 ,
  a = { ':Gitsigns stage_hunk<cr>' , 'stage hunk'  } ,
  b = {
    name = '+Branches'          ,
    b = { ':FzfLua git_branches<cr>' , 'Checkout branch'     } ,
    d = { ':GBranches diff<cr>'      , 'Diff branch'         } ,
    m = { ':GBranches merge<cr>'     , 'Merge branch'        } ,
    n = { ':GBranches create<cr>'    , 'Create branch'       } ,
    r = { ':GBranches rebase<cr>'    , 'Rebase with branch'  } ,
    t = { ':GTags<cr>'                         , 'Checkout tags'    } ,
    }                             ,
  B = { ':Git blame<cr>'             , 'blame'            }             ,
  c = {
    name = '+Ccommands'                   ,
    a = { ':FzfLua git_commits<cr>'            , 'branch commits'   } ,
    b = { ':FzfLua git_bcommits<cr>'           , 'buffer commits'   } ,
    c = { ':Git commit<cr>'                    , 'commit'           } ,
    f = { ':GV!<cr>'                          , 'GV file commit'  } ,
    g = { ':GV<cr>'                           , 'GV commits'      } ,
    o = { ':FzfLua git_branches<cr>'           , 'Checkout branch'  } ,
    s = { ':!git commit --amend --no-edit<cr>' , 'ammend commit'    } ,
     }                                       ,
  d = {
    name = '+Diff'              ,
    d = { ':tab Git diff<cr>'        , 'diff all'   } ,
    t = { ':Gitsigns diffthis<cr>'   , 'diff this'  } ,
    }                             ,
  g = { ':Git<cr>'               , 'Git '               } ,
  G = { ':Neogit<cr>'                   , 'Git '               } ,
  h = { ':Gitsigns preview_hunk<cr>' , 'preview hunk'       } ,
  l = { ':Gclog<cr>'                 , 'logs'               } ,
  L = { ':Git log --stat<cr>'        , 'logs with changes'  } ,
  p = {
    name = '+Pcommands'        ,
    f = { ':Git fetch<cr>'          , 'push'  } ,
    m = 'pull --merge origin'  ,
    p = { ':Git pull<cr>'           , 'pull'  } ,
    r = 'pull --rebase origin' ,
    u = { ':Git push<cr>'           , 'push'  } ,
    }                            ,
  s = {
    name = '+Scommands'              ,
    a = { ':Gitsigns stage_hunk<cr>'      , 'stage hunk'        } ,
    b = { ':Gitsigns stage_buffer<cr>'    , 'stage buffer'      } ,
    h = { ':FzfLua git_stash<cr>'         , 'git stash list'    } ,
    r = { ':Gitsigns reset_buffer<cr>'    , 'reset buffer'      } ,
    s = { ':Git stash<cr>'                , 'stash'             } ,
    u = { ':Gitsigns undo_stage_hunk<cr>' , 'undo staged hunk'  } ,
    }                                  ,
  t = {
    name = '+Gutter'                           ,
    d = { ':Gitsigns toggle_deleted<cr>'            , 'toggle deleted hunks'  } ,
    n = { ':Gitsigns toggle_numhl<cr>'              , 'toggle num highlight'  } ,
    l = { ':Gitsigns toggle_current_line_blame<cr>' , 'toggle num highlight'  } ,
    s = { ':Gitsigns toggle_signs<cr>'              , 'toggle signs'          } ,
    h = { ':Gitsigns toggle_linehl<cr>'             , 'highlight hunks'       } ,
    }                                            ,
  u = { ':Gitsigns reset_hunk<cr>'                  , 'reset hunk'                    }     ,
 -- ['[']= { ':diffget //2 | diffupdate'             , 'hunk from the target parent'  }      ,
  --[']'] = { ':diffget //3 | diffupdate'             , 'hunk from the merge parent'   }      ,
  i = {
    name = '+advance'                   ,
    m = { ':Git merge --continue<cr>'        , 'merge continue'     } ,
    r = { ':Git rebase --continue<cr>'       , 'rebase continue'    } ,
    p = { ':Git push --force<cr>'            , 'push force'         } ,
    c = { ':Git commit -m "fast-commit"<cr>' , 'quick commit'       } ,
    s = { ':Git rebase -i HEAD~2<cr>'        , 'squash cur commit'  } ,
    f = { ':!git checkout -- .<cr>'          , 'flus changes'       } ,
    q = 'fast squash'                   ,
    n = 'push upstream new'             ,
    g = 'reset branch'                  ,
    j = 'insert jira ticket no.'        ,
    }                                     ,
   }
})

cmd[[ 
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'rebase':{
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} -C {cwd} pull origin --rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:true,
      \ },
      \}
]]
