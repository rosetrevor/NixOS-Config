require("trevbawt.plugins")
require("trevbawt")
require("lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

vim.g.netrw_banner = 0

vim.lsp.enable('pyright')
--local lspconfig = require("lspconfig")
--lspconfig.ruff.setup({
--  init_options = {
--    settings = {
--      -- Ruff language server settings go here
--    }
--  }
--})
--lspconfig.basedpyright.setup()
vim.cmd("colorscheme catppuccin")

