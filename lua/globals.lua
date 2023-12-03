local utils = require "utils"

vim.g.is_mac = utils.has("macunix") and true or false
vim.g.logging_level = "info"
vim.g.loaded_perl_provider = 0  -- Disable perl provider
vim.g.loaded_ruby_provider = 0  -- Disable ruby provider
vim.g.loaded_node_provider = 0  -- Disable node provider
vim.g.did_install_default_menus = 1  -- do not load menu

-- ref: https://neovim.io/doc/user/provider.html
if utils.executable('python3') then
  vim.g.python3_host_prog = "/home/sal/.pyenv/versions/py3nvim/bin/python" --vim.fn.exepath("python3")
else
  vim.api.nvim_err_writeln("Python3 not found!")
  return
end

vim.g.mapleader = ','

vim.cmd [[language en_US.UTF-8]]

-- disbling some plugins
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_sql_completion = 1
