local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
--
-- Lspconfig
--

-- Use an on_attach function to only map the following keys after
-- the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', '<localleader>gg', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<localleader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<localleader>,', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<localleader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<localleader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<localleader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<localleader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<localleader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<localleader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<localleader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<localleader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<localleader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Updated diagnostic mappings using vim.diagnostic
  buf_set_keymap('n', '<localleader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<localleader>[', '<cmd>lua vim.diagnostic.jump({ float = true, count =-1 })<CR>', opts)
  buf_set_keymap('n', '<localleader>]', '<cmd>lua vim.diagnostic.jump({ float = true, count=1 })<CR>', opts)
  buf_set_keymap('n', '<localleader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  buf_set_keymap('n', '<localleader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  buf_set_keymap('v', '<localleader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)


  -- Disable Autoformat
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end


-- nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Don't attach LSP for projects in below table
local ignoredProject = { 'euler[-]ps' }
local cwd = vim.loop.cwd()
local haltLsp = false
for _, proj in ipairs(ignoredProject) do
  ---@diagnostic disable-next-line: cast-local-type
  haltLsp = haltLsp or string.find(cwd, proj)
end
-- Use a loop t conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'hls', 'bashls', 'vimls', 'rust_analyzer', 'pyright', 'rescriptls' }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  })
end

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'use' },
      },
    },
  }
})

if not haltLsp then
  vim.lsp.config('purescriptls', {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      purescript = {
        addSpagoSources = true,
        addNpmPath = true
      }
    }
  })
end

vim.lsp.enable({ 'lua_ls', 'purescriptls' })
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = true,
})


--
-- Nvim-cmp
--

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
  formatting = {
    format = lspkind.cmp_format()
  },
  mapping = {
    --    ['<C-p>'] = cmp.mapping.select_prev_item(),
    --    ['<C-n>'] = cmp.mapping.select_next_item(),
    --    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --    ['<C-Space>'] = cmp.mapping.complete(),
    --    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- use Tab and shift-Tab to navigate autocomplete menu
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'tags' },
    { name = 'buffer' },
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--
-- Diagnostics
--

-- Set diagnostic sign icons using the new API with FiraCode ligatures
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warning,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Information,
    }
  }
})

require("trouble").setup {}
