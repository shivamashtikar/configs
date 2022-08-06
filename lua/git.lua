local cmd = vim.cmd -- execute Vim commands
local u = require('my-utils')
local nmap = u.nmap

cmd [[ 
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

nmap('<C-n>', ':call NextAction()<CR>')
nmap('<C-p>', ':call PrevAction()<CR>')

nmap('<leader>gij', ':exe "normal! a" . matchstr(fugitive#Head(), "PICAF-[0-9]*"). " "<CR>a')
nmap('<leader>gpr', ':Git pull --rebase origin/')
nmap('<leader>gpm', ':Git pull --merge origin/')

u.wkreg({
  g = {
    name = '+git',
    a = { ':Gitsigns stage_hunk<cr>', 'stage hunk' },
    b = {
      name = '+Branches',
      b = { ':FzfLua git_branches<cr>', 'Checkout branch' },
      d = { ':GBranches diff<cr>', 'Diff branch' },
      m = { ':GBranches merge<cr>', 'Merge branch' },
      n = { ':GBranches create<cr>', 'Create branch' },
      r = { ':GBranches rebase<cr>', 'Rebase with branch' },
      t = { ':GTags<cr>', 'Checkout tags' },
    },
    B = { ':Git blame<cr>', 'blame' },
    c = {
      name = '+Ccommands',
      a = { ':FzfLua git_commits<cr>', 'branch commits' },
      b = { ':FzfLua git_bcommits<cr>', 'buffer commits' },
      c = { ':Git commit<cr>', 'commit' },
      f = { ':GV!<cr>', 'GV file commit' },
      g = { ':GV<cr>', 'GV commits' },
      o = { ':FzfLua git_branches<cr>', 'Checkout branch' },
      s = { u.syscmd({ 'git', 'commit', '--amend', '--no-edit' }), 'ammend commit' },
    },
    d = {
      name = '+Diff',
      d = { ':tab Git diff<cr>', 'diff all' },
      t = { ':Gitsigns diffthis<cr>', 'diff this' },
    },
    g = { ':Git<cr>', 'Git ' },
    G = { ':Neogit<cr>', 'Git ' },
    h = { ':Gitsigns preview_hunk<cr>', 'preview hunk' },
    l = {
      name = "+logs",
      c = { ':Git log --stat<cr>', 'logs with changes' },
      l = { ':Gclog<cr>', 'logs' },
      s = { ":Git log  --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat<cr>",
        "log tree with files" },
    },
    p = {
      name = '+Pcommands',
      f = { u.syscmd({ 'git', 'fetch' }), 'fetch' },
      m = 'pull --merge origin',
      p = { u.syscmd({ 'git', 'pull' }), 'pull' },
      r = 'pull --rebase origin',
      u = { u.syscmd({ 'git', 'push' }), 'push' },
    },
    s = {
      name = '+Scommands',
      a = { ':Gitsigns stage_hunk<cr>', 'stage hunk' },
      b = { ':Gitsigns stage_buffer<cr>', 'stage buffer' },
      h = { ':FzfLua git_stash<cr>', 'git stash list' },
      r = { ':Gitsigns reset_buffer<cr>', 'reset buffer' },
      s = { u.syscmd({ 'git', 'stash' }), 'stash' },
      t = { u.quickGS, 'git status' },
      u = { ':Gitsigns undo_stage_hunk<cr>', 'undo staged hunk' },
    },
    t = {
      name = '+Gutter',
      d = { ':Gitsigns toggle_deleted<cr>', 'toggle deleted hunks' },
      n = { ':Gitsigns toggle_numhl<cr>', 'toggle num highlight' },
      l = { ':Gitsigns toggle_current_line_blame<cr>', 'toggle num highlight' },
      s = { ':Gitsigns toggle_signs<cr>', 'toggle signs' },
      h = { ':Gitsigns toggle_linehl<cr>', 'highlight hunks' },
    },
    u = { ':Gitsigns reset_hunk<cr>', 'reset hunk' },
    -- ['[']= { ':diffget //2 | diffupdate'             , 'hunk from the target parent'  }      ,
    --[']'] = { ':diffget //3 | diffupdate'             , 'hunk from the merge parent'   }      ,
    i = {
      name = '+advance',
      m = { u.syscmd({ 'git', 'merge', '--continue' }), 'merge continue' },
      r = { u.syscmd({ 'git', 'rebase', '--continue' }), 'rebase continue' },
      p = { u.syscmd({ 'git', 'push', '--force' }), 'push force' },
      c = { u.syscmd({ 'git', 'commit', '-m', '"fast-commit"' }), 'quick commit' },
      s = { u.syscmd({ 'git', 'rebase', '-i', 'HEAD~2' }), 'squash cur commit' },
      f = { u.syscmd({ 'git', 'checkout', '--', '.' }), 'flus changes' },
      q = 'fast squash',
      n = {
        function()
          local op = vim.api.nvim_call_function('fugitive#Head', {})
          u.syscmd({ 'git', 'push', '--set-upstream', 'origin', op })()
        end,
        'push upstream new'
      },
      g = {
        function()
          local op = vim.api.nvim_call_function('fugitive#Head', {})
          u.syscmd({ 'git', 'reset', '--hard', 'origin/' .. op })()
        end
        , 'reset branch'
      },
      j = 'insert jira ticket no.',
    },
  }
})

cmd [[
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
