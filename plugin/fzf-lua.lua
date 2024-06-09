require('fzf-lua').setup{
  winopts = {
    fullscreen = true,
    preview = {
      vertical = 'up:60%',      -- up|down:size
      flip_columns   = 100,             -- #cols to switch to horizontal on flex
      horizontal     = 'right:50%',     -- right|left:size
      -- hidden         = 'hidden',      -- hidden|nohidden
      layout = "vertical"
    },
  },
  fzf_opts = {
    ['--layout'] = "default",
  },
  files = {
    rg_opts = "--color=never --files --hidden --follow --no-ignore -g '!.git'",
  }
}
