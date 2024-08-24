local cmd = vim.cmd -- execute Vim commands
local u = require('my-utils')
local wk = require("which-key")
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
nmap('<leader>gpr', ':Git pull --rebase origin ')
nmap('<leader>gpm', ':Git pull --merge origin ')

wk.add({
  {'<leader>g', group= '+git'},
    {'<leader>ga', ':Gitsigns stage_hunk<cr>', desc='stage hunk' },
    {'<leader>gB', ':Git blame<cr>', desc='blame' },
    {'<leader>gG', ':Git|MaximizerToggle<cr>', desc='Git ' },
    {'<leader>gg', ':Neogit<cr>', desc='Git ' },
    {'<leader>gh', ':Gitsigns preview_hunk<cr>', desc='preview hunk' },
    {'<leader>gu', ':Gitsigns reset_hunk<cr>', desc='reset hunk' },
  {'<leader>gb', group= '+Branches'},
  {'<leader>gbb', ':FzfLua git_branches<cr>', desc='Checkout branch' },
  {'<leader>gbd', ':GBranches diff<cr>', desc='Diff branch' },
  {'<leader>gbm', ':GBranches merge<cr>', desc='Merge branch' },
  {'<leader>gbn', ':GBranches create<cr>', desc='Create branch' },
  {'<leader>gbr', ':GBranches rebase<cr>', desc='Rebase with branch' },
  {'<leader>gbt', ':GTags<cr>', desc='Checkout tags' },
  {'<leader>gc', group= '+Ccommands'},
  {'<leader>gca', ':FzfLua git_commits<cr>', desc='branch commits' },
  {'<leader>gcb', ':FzfLua git_bcommits<cr>', desc='buffer commits' },
  {'<leader>gcc', ':Git commit<cr>', desc='commit' },
  {'<leader>gcf', ':GV!<cr>', desc='GV file commit' },
  {'<leader>gcg', ':GV<cr>', desc='GV commits' },
  {'<leader>gco', ':FzfLua git_branches<cr>', desc='Checkout branch' },
  {'<leader>gcs', u.syscmd({ 'git', 'commit', '--amend', '--no-edit' }), desc='ammend commit' },
  {'<leader>gd', group= '+Diff'},
  {'<leader>gdd', ':tab Git diff<cr>', desc='diff all' },
  {'<leader>gdt', ':Gitsigns diffthis<cr>', desc='diff this' },
  {'<leader>gl', group= '+logs'},
  {'<leader>glc', ':Git log --stat<cr>', desc='logs with changes' },
  {'<leader>gll', ':Gclog<cr>', desc='logs' },
  {'<leader>gls', ":Git log  --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat<cr>", desc="log tree with files" },
  {'<leader>gp', group= '+P'},
  {'<leader>gpf', u.syscmd({ 'git', 'fetch' }), desc='fetch' },
  {'<leader>gpp', u.syscmd({ 'git', 'pull' }), desc='pull' },
  {'<leader>gpu', u.syscmd({ 'git', 'push' }), desc='push' },
  {'<leader>gpm', desc='pull --merge origin'},
  {'<leader>gpr', desc='pull --rebase origin'},
  {'<leader>gij', desc="insert ticket from branch"},
  {'<leader>gs', group= '+Scommands'},
  {'<leader>gsa', ':Gitsigns stage_hunk<cr>', desc='stage hunk' },
  {'<leader>gsb', ':Gitsigns stage_buffer<cr>', desc='stage buffer' },
  {'<leader>gsh', ':FzfLua git_stash<cr>', desc='git stash list' },
  {'<leader>gsr', ':Gitsigns reset_buffer<cr>', desc='reset buffer' },
  {'<leader>gss', u.syscmd({ 'git', 'stash' }), desc='stash' },
  {'<leader>gst', u.quickGS, desc='git status' },
  {'<leader>gsu', ':Gitsigns undo_stage_hunk<cr>', desc='undo staged hunk' },
  {'<leader>gt', group= '+Gutter'},
  {'<leader>gtd', ':Gitsigns toggle_deleted<cr>', desc='toggle deleted hunks' },
  {'<leader>gtn', ':Gitsigns toggle_numhl<cr>', desc='toggle num highlight' },
  {'<leader>gtl', ':Gitsigns toggle_current_line_blame<cr>', desc='toggle num highlight' },
  {'<leader>gts', ':Gitsigns toggle_signs<cr>', desc='toggle signs' },
  {'<leader>gth', ':Gitsigns toggle_linehl<cr>', desc='highlight hunks' },
  {'<leader>gi', group= '+advance'},
  {'<leader>gim', u.syscmd({ 'git', 'merge', '--continue' }), desc='merge continue' },
  {'<leader>gir', u.syscmd({ 'git', 'rebase', '--continue' }), desc='rebase continue' },
  {'<leader>gip', u.syscmd({ 'git', 'push', '--force' }), desc='push force' },
  {'<leader>gic', u.syscmd({ 'git', 'commit', '-m', '"fast-commit"' }), desc='quick commit' },
  {'<leader>gis', u.syscmd({ 'git', 'rebase', '-i', 'HEAD~2' }), desc='squash cur commit' },
  {'<leader>gif', u.syscmd({ 'git', 'checkout', '--', '.' }), desc='flus changes' },
  {'<leader>gin', function()
          local op = vim.api.nvim_call_function('fugitive#Head', {})
          u.syscmd({ 'git', 'push', '--set-upstream', 'origin', op })()
        end,
        desc='push upstream new' },
  {'<leader>gig', function()
          local op = vim.api.nvim_call_function('fugitive#Head', {})
          u.syscmd({ 'git', 'reset', '--hard', 'origin/' .. op })()
        end
        , desc='reset branch' },
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
