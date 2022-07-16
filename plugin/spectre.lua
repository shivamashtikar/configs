require('spectre').setup({
  live_update = true, -- auto excute search again when you write any file in vim
  mapping={
    ['send_to_qf'] = {
        map = "<leader>sq",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
    },
    ['replace_cmd'] = {
        map = "<leader>sc",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command"
    },
    ['show_option_menu'] = {
        map = "<leader>so",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option"
    },
    ['run_replace'] = {
        map = "<leader>sr",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all"
    },
    ['change_view_mode'] = {
        map = "<leader>sm",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode"
    },
    -- you can put your mapping here it only use normal mode
  },
})
