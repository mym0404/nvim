-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set({ "n", "v", "i" }, "<M-w>", ":bd<MR>", {
--   desc = "Mlose buffer",
--   silent = true,
-- })

for _, key in ipairs({ "jj", "jk", "kj" }) do
  vim.keymap.set({ "i" }, key, "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
end

vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +3<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -3<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Up>", "<cmd>resize +3<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -3<cr>", { desc = "Decrease window height" })

-- vim.keymap.set({ "n", "v" }, "y", '"ay', { desc = "Yank to register a" })
-- vim.keymap.set({ "n", "v" }, "p", '"ap', { desc = "Paste from register a" })
-- vim.keymap.set({ "n", "v" }, "P", '"aP', { desc = "Paste before from register a" })
-- vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete without register" })
-- vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without register" })
