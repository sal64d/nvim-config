local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local utils = require("utils")
local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local caps = require('cmp_nvim_lsp').default_capabilities()

-- quickfix list 
local set_qflist = function(buf_num, severity)
  local diagnostics = nil 
  diagnostics = diagnostic.get(buf_num, { severity = severity })

  local qf_items = diagnostic.toqflist(diagnostics)
  vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items})

  -- open list by default 
  vim.cmd[[copen]]
end

local on_attach = function(client, bufnr)
  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end 

  map("n", "gd", vim.lsp.buf.defination) -- go to defination 
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<C-k", vim.lsp.buf.sinature_help)
  map("n", "<space>rn", vim.lsp.buf.rename) -- variable rename 
  map("n", "gr", vim.lsp.buf.references)
  map("n", "[d", diagnostic.goto_prev)
  map("n", "]d", diagnostic.goto_next)

  map("n", "<space>qw", diagnostic.setqflist)
  map("n", "<space>qb", function() set_qflist(bufnr) end)
  
  map("n", "<space>ca", vim.lsp.buf.code_action)
  
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<space>f", vim.lsp.buf.format)
  end

  api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        source = "always",
        prefix = " ",
      }

      if not vim.b.diagnostics_pos then 
        vim.b.diagnostics_pos = {nil, nil}
      end

      local cursor_pos = api.nvim_win_get_cursor(0) 
      
       if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
          and #diagnostic.get() > 0
      then
        diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos

    end,
  })

  -- The below command will highlight the current variable and its usages in the buffer.
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

    local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    api.nvim_create_autocmd("CursorHold" , {
      group = gid,
      buffer = bufnr,
      callback = function ()
        lsp.buf.document_highlight()
      end
    })

    api.nvim_create_autocmd("CursorMoved" , {
      group = gid,
      buffer = bufnr,
      callback = function ()
        lsp.buf.clear_references()
      end
    })
  end

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end

end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  root_dir = require('lspconfig.util').root_pattern('.git'),
  capabilities = caps,
}

-- Python
nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  capabilities = caps,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        ruff = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        
        -- type checker
        pylsp_mypy = {
            enabled = true,
            overrides = { "--python-executable", py_path, true },
            report_progress = true,
            live_mode = false
        },
        
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        
        -- import sorting
        isort = { enabled = true },
      },
    },
  },
}

-- lua 
--nvim_lsp.vimls.setup {
--  on_attach = on_attach,
--  capabilities = caps,
--}

-- vim
nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          fn.stdpath("data") .. "/lazy/emmylua-nvim",
          fn.stdpath("config"),
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      }
    }
  },
  capabilities = caps,
}

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = '🆇', texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = '⚠️', texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = 'ℹ️', texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = '', texthl = "DiagnosticSignHint" })

-- global config for diagnostic
diagnostic.config {
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
}

