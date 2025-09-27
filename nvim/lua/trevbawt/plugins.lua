local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fin.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  --'nvim-treesitter/nvim-treesitter',
  --'nvim-treesitter/playground',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  {
    'neovim/nvim-lspconfig',
    config = function()
      require "lspconfig"
    end,
  },
  'echasnovski/mini.nvim',
  'neovim/nvim-lspconfig',
  'ThePrimeagen/vim-be-good',
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  'folke/tokyonight.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate'
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
	"pyright",
      },
    },
  },
  --'custom_plugins' = 'custom_plugins'
 }

local opts = {}

require("lazy").setup({
  spec = {
    plugins
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will automatically be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = {enabled = true },
  opts = {colorscheme = "catppuccin"},
})
