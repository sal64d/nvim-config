local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local caps = require("cmp_nvim_lsp").default_capabilities()

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = "🆇", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "⚠️", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "ℹ️", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- global config for diagnostic
diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  severity_sort = true,
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- clangd
nvim_lsp.clangd.setup {}

-- TypeScript
nvim_lsp.tsserver.setup {}
  --root_dir = require("lspconfig.util").root_pattern(".git"),

-- Python
nvim_lsp.pylsp.setup {}

-- vim
--nvim_lsp.vimls.setup {
--  on_attach = on_attach,
--  capabilities = caps,
--}

-- lua
--nvim_lsp.lua_ls.setup {
--  on_attach = on_attach,
--  settings = {
--    Lua = {
--      runtime = {
--        version = "LuaJIT"
--      },
--      diagnostics = {
--        globals = { "vim" },
--      },
--      workspace = {
--        library = {
--          fn.stdpath("data") .. "/lazy/emmylua-nvim",
--          fn.stdpath("config"),
--        },
--        maxPreload = 2000,
--        preloadFileSize = 50000,
--      }
--    }
--  },
--  capabilities = caps,
--}
---- quickfix list
--local set_qflist = function(buf_num, severity)
--  local diagnostics = nil
--  diagnostics = diagnostic.get(buf_num, { severity = severity })
--
--  local qf_items = diagnostic.toqflist(diagnostics)
--  vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })
--
--  -- open list by default
--  vim.cmd([[copen]])
--end
--
--local custom_attach = function(client, bufnr)
--  -- Mappings.
--  local map = function(mode, l, r, opts)
--    opts = opts or {}
--    opts.silent = true
--    opts.buffer = bufnr
--    keymap.set(mode, l, r, opts)
--  end
--
--  map("n", "gd", vim.lsp.buf.defination) -- go to defination
--  map("n", "K", vim.lsp.buf.hover)
--  map("n", "<C-k>", vim.lsp.buf.sinature_help)
--  map("n", "<space>rn", vim.lsp.buf.rename) -- variable rename
--  map("n", "gr", vim.lsp.buf.references)
--  map("n", "[d", diagnostic.goto_prev)
--  map("n", "]d", diagnostic.goto_next)
--
--  map("n", "<space>qw", diagnostic.setqflist)
--  map("n", "<space>qb", function() set_qflist(bufnr) end)
--
--  map("n", "<space>ca", vim.lsp.buf.code_action)
--
--  if client.server_capabilities.documentFormattingProvider then map("n", "<space>f", vim.lsp.buf.format) end
--
--  if vim.g.logging_level == "debug" then
--    local msg = string.format("Language server %s started!", client.name)
--    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
--  end
--end


