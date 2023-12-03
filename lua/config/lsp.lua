local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local utils = require("utils")

local nvim_lsp = require("lspconfig")

local protocol = require("vim.lsp.protocol")

-- TypeScript


nvim_lsp.tsserver.setup {
  --on_attach = on_attach,
  -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  -- cmd = { "yarn", "exec", "typescript-language-server", "--stdio" },
  root_dir = require('lspconfig.util').root_pattern('.git')

}
