require("trevbawt")
require("trevbawt.plugins")
require("lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

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

