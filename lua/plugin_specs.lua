local utils = require("utils")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- install lazy
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-emoji",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },

   {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("config.lsp")
    end,
  },

  {
    "MunifTanjim/eslint.nvim",
    event = {"BufRead", "BufNewFile"},
    dependencies = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function ()
      require("config.eslint")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    config = function()
      require("config.nvim_hop")
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    config = function()
      require("config.hlslens")
    end,
  },

  {
    "Yggdroot/LeaderF",
    cmd = "Leaderf",
    build = function()
      vim.cmd(":LeaderfInstallCExtension")
    end,
  },
  
  "nvim-lua/plenary.nvim",

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("config.statusline")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = { "BufEnter" },
    config = function()
      require("config.bufferline")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = 'ibl',
    config = function()
      require("config.indent-blankline")
    end,
  },

  { "SirVer/ultisnips", 
    dependencies = {
      "honza/vim-snippets",
    }, 
    event = "InsertEnter" 
  },

  { "907th/vim-auto-save", event = "InsertEnter" },

  { "stevearc/dressing.nvim" },

  { "nvim-zh/better-escape.vim", event = { "InsertEnter" } },

  { "sbdchd/neoformat", cmd = { "Neoformat" } },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    "sindrets/diffview.nvim"
  },

  {
    "tmux-plugins/vim-tmux",
    ft = { "tmux" },
  },

  { "andymass/vim-matchup", event = "BufRead" },

  { "skywind3000/asyncrun.vim", lazy = true, cmd = { "AsyncRun" } },
  { "cespare/vim-toml", ft = { "toml" }, branch = "main" },

  -- showing keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.which-key")
    end,
  },

  -- show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VeryLazy" },

  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<space>s" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end,
  },

  {
    'wesleimp/stylua.nvim'
  },

  {
    'Mofiqul/vscode.nvim',
    config = function()
      require("vscode").load()
    end,
  },

}

