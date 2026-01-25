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

-- lualine Bubbles Config
local colors = {
  blue   = '#b4befe',
  green   = '#a6e3a1',
  black  = '#11111b',
  peach = '#fab387',
  white  = '#bac2de',
  red    = '#f38ba8',
  violet = '#f5c2e7',
  grey   = '#313244',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.peach },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.green } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}
-- end lualine bubbles config


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
  },
  'echasnovski/mini.nvim',
  'ThePrimeagen/vim-be-good',
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      require("catppuccin").setup({
      	color_overrides = {
      	  mocha = { base = "#11111b", mantle = "#11111b"}
      	}
      })
    end
  },
  --'folke/tokyonight.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = {
	"html",
	"json",
	"lua",
	"luadoc",
	"markdown",
        "python",
	"vim",
	"vimdoc",
	"query",
	"xml",
	"yaml",
      },
    }
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
	"pyright",
	"basedpyright",
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'christoomey/vim-tmux-navigator',
    lazy=false,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<c-h>', '<cmd>TmuxNagivateLeft<cr>' },
      { '<c-j>', '<cmd>TmuxNagivateDown<cr>' },
      { '<c-k>', '<cmd>TmuxNagivateUp<cr>' },
      { '<c-l>', '<cmd>TmuxNagivateRight<cr>' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
           theme = bubbles_theme,
           component_separators = '',
           section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {
            '%=', --[[ add your center components here in place of this comment ]]
          },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      })
    end
  },
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
