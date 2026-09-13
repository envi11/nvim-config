vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("i", "<C-s>", ":w<CR>a")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-q>", ":q!<CR>")
vim.keymap.set("n", "<C-q>", ":q!<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
--vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y') -- why doesnt this work
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
