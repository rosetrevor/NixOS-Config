vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<C-C>", '"*y :let @+=@*<CR>')
-- vim.keymap.set("n", "<C-V>", '"+P')

vim.keymap.set('n', '<c-h>', '<cmd>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>grep', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>buf', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
