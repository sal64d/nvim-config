local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup {
  snippet = {
  },
  mapping = cmp.mapping.preset.insert {
  },
  sources = {
    { name = "nvim_lsp" }, -- For nvim-lsp
    { name = "ultisnips" }, -- For ultisnips user.
    { name = "path" }, -- for path completion
    { name = "buffer", keyword_length = 2 }, -- for buffer word completion
  },
  completion = {},
  view = {},
  formatting = {},
}

