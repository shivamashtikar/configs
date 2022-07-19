require("onedark").setup({
   comment_style = "italic",
  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      MatchParen = { fg = c.cyan0, bg = c.bg_visual, style = "bold "}
    }
  end,
  colors = {
    bg_visual =  '#5c6370'
  }
})
