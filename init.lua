-- This is my nvim config 
-- - Heavily referenced from https://github.com/jdhao/nvim-config/
-- Author: Sal

vim.loader.enable()
local p = vim.fn.stdpath("config")

require "globals"
vim.cmd("source" .. p .. "/viml_conf/options.vim")
vim.cmd("source" .. p .. "/viml_conf/autocommands.vim")
require "custom-autocmd"
require "mappings"
require "plugin_specs"
vim.cmd("source" .. p .. "/viml_conf/plugins.vim")

