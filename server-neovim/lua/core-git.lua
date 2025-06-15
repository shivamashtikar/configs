local u = require('my-utils')
local wk = require('which-key')
local nmap = u.nmap
local cmd = vim.cmd

-- Gitsigns setup
require('gitsigns').setup{
  current_line_blame = true,
}

-- Conflict marker highlighting
vim.g.conflict_marker_highlight_group = ''
vim.g.conflict_marker_begin = '^<<<<<<< .*$'
vim.g.conflict_marker_end   = '^>>>>>>> .*$'
cmd[[
  highlight default link ConflictMarkerBegin DiffAdd
  highlight default link ConflictMarkerOurs DiffText
  highlight default link ConflictMarkerTheirs DiffChange
  highlight default link ConflictMarkerEnd DiffAdd
  highlight default link ConflictMarkerCommonAncestorsHunk DiffText
]]
-- Fallback highlights if theme doesn't link them well
cmd[[
  highlight ConflictMarkerBegin guibg=#2f7366 guifg=#c8ccc8
  highlight ConflictMarkerOurs guibg=#2e5049 guifg=#c8ccc8
  highlight ConflictMarkerTheirs guibg=#344f69 guifg=#c8ccc8
  highlight ConflictMarkerEnd guibg=#2f628e guifg=#c8ccc8
  highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81 guifg=#c8ccc8
]]


-- Navigation for conflicts and hunks
cmd [[
function! ServerPrevAction() abort
  try
    execute 'normal! [' . v:count1 . 'c' " Standard way to jump to prev conflict marker
    execute 'ConflictMarkerPrevHunk'
  catch /E486: Pattern not found/
    " If no conflict marker, try gitsigns
    silent! Gitsigns prev_hunk
  catch /No conflict markers found/
    silent! Gitsigns prev_hunk
  catch /.*/
    " Catch any other error from ConflictMarker and try Gitsigns
    silent! Gitsigns prev_hunk
  endtry
endfunction

function! ServerNextAction() abort
  try
    execute 'normal! ]' . v:count1 . 'c' " Standard way to jump to next conflict marker
    execute 'ConflictMarkerNextHunk'
  catch /E486: Pattern not found/
    silent! Gitsigns next_hunk
  catch /No conflict markers found/
    silent! Gitsigns next_hunk
  catch /.*/
    silent! Gitsigns next_hunk
  endtry
endfunction
]]

nmap('<C-n>', ':call ServerNextAction()<CR>')
nmap('<C-p>', ':call ServerPrevAction()<CR>')

-- Git related keymaps using which-key
wk.register({
    ['<leader>g'] = { name = '+git' },
    ['<leader>ga'] = { ':Gitsigns stage_hunk<cr>', 'Stage Hunk' },
    ['<leader>gB'] = { ':Git blame<cr>', 'Blame' },
    ['<leader>gg'] = { ':Git<cr>', 'Fugitive Status' }, -- Simplified from |MaximizerToggle
    ['<leader>gh'] = { ':Gitsigns preview_hunk<cr>', 'Preview Hunk' },
    ['<leader>gu'] = { ':Gitsigns reset_hunk<cr>', 'Reset Hunk' },

    ['<leader>gb'] = { name = '+branches' },
    ['<leader>gbb'] = { ':FzfLua git_branches<cr>', 'Checkout branch (FZF)' },
    -- For fzf-checkout.vim (if preferred for certain actions)
    -- '<leader>gbo'] = {':GBranches<CR>', 'FZF Checkout Branches'},

    ['<leader>gc'] = { name = '+commits' },
    ['<leader>gca'] = { ':FzfLua git_commits<cr>', 'Branch Commits (FZF)' },
    ['<leader>gcb'] = { ':FzfLua git_bcommits<cr>', 'Buffer Commits (FZF)' },
    ['<leader>gcc'] = { ':Git commit<cr>', 'Commit' },
    ['<leader>gcs'] = { u.syscmd({ 'git', 'commit', '--amend', '--no-edit' }), 'Amend Commit (no edit)' },

    ['<leader>gd'] = { name = '+diff' },
    ['<leader>gdd'] = { ':tab Git diff<cr>', 'Diff All (tab)' },
    ['<leader>gdv'] = { ':DiffviewOpen<CR>', 'Diff View Open'},
    ['<leader>gdc'] = { ':DiffviewClose<CR>', 'Diff View Close'},
    ['<leader>gdh'] = { ':DiffviewFileHistory<CR>', 'Diff View File History'},


    ['<leader>gl'] = { name = '+logs' },
    ['<leader>gll'] = { ':Git log<cr>', 'Log (current file)' },
    ['<leader>gla'] = { ':Git log --<cr>', 'Log (all)' },


    ['<leader>gp'] = { name = '+push/pull/fetch' },
    ['<leader>gpf'] = { u.syscmd({ 'git', 'fetch', '--all', '--prune' }), 'Fetch All & Prune' },
    ['<leader>gpp'] = { u.syscmd({ 'git', 'pull' }), 'Pull' },
    ['<leader>gP'] = { u.syscmd({ 'git', 'push' }), 'Push' }, -- Shift+P for push
    ['<leader>gpr'] = { ':Git pull --rebase origin ', 'Pull --rebase origin [branch]' },
    ['<leader>gpm'] = { ':Git pull --merge origin ', 'Pull --merge origin [branch]' },


    ['<leader>gs'] = { name = '+stage/stash/status' },
    ['<leader>gsa'] = { ':Gitsigns stage_hunk<cr>', 'Stage Hunk (Gitsigns)' },
    ['<leader>gsb'] = { ':Gitsigns stage_buffer<cr>', 'Stage Buffer (Gitsigns)' },
    ['<leader>gsh'] = { ':FzfLua git_stash<cr>', 'Stash List (FZF)' },
    ['<leader>gsr'] = { ':Gitsigns reset_buffer<cr>', 'Reset Buffer (Gitsigns)' },
    ['<leader>gss'] = { u.syscmd({ 'git', 'stash' }), 'Stash Current Changes' },
    ['<leader>gst'] = { u.quickGS, 'Quick Git Status (notify)' },
    ['<leader>gsu'] = { ':Gitsigns undo_stage_hunk<cr>', 'Undo Staged Hunk (Gitsigns)' },

    ['<leader>gt'] = { name = '+toggle gitsigns' },
    ['<leader>gtd'] = { ':Gitsigns toggle_deleted<cr>', 'Toggle Deleted Hunks' },
    ['<leader>gtn'] = { ':Gitsigns toggle_numhl<cr>', 'Toggle Number Highlight' },
    ['<leader>gtl'] = { ':Gitsigns toggle_current_line_blame<cr>', 'Toggle Line Blame' },
    ['<leader>gts'] = { ':Gitsigns toggle_signs<cr>', 'Toggle Signs' },
    ['<leader>gth'] = { ':Gitsigns toggle_linehl<cr>', 'Toggle Line Highlight' },

    ['<leader>gi'] = { name = '+git advanced' },
    ['<leader>gim'] = { u.syscmd({ 'git', 'merge', '--continue' }), 'Merge Continue' },
    ['<leader>gir'] = { u.syscmd({ 'git', 'rebase', '--continue' }), 'Rebase Continue' },
    ['<leader>gip'] = { u.syscmd({ 'git', 'push', '--force-with-lease' }), 'Push --force-with-lease' },
    ['<leader>gic'] = { u.syscmd({ 'git', 'commit', '-m', '"fast-commit"' }), 'Quick Commit "fast-commit"' },
    ['<leader>gis'] = { ':Git rebase -i HEAD~~<CR>', 'Interactive Rebase (HEAD~2)' }, -- Fugitive command
    ['<leader>gif'] = { u.syscmd({ 'git', 'checkout', '--', '.' }), 'Discard all local changes' },

}, { prefix = "" })

-- fzf-checkout.vim specific actions (if fzf-checkout.vim is used alongside fzf-lua for branches)
-- This is from your original git.lua, might be useful if you prefer its interface for some actions.
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

print("Minimal Git config loaded")
