require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp" ,
    tab_size = 12,
    offsets = {{
      filetype = "NvimTree",
      text = "File Explorer" ,
      highlight = "Directory",
      text_align = "left"
    }
    }
  }
}
