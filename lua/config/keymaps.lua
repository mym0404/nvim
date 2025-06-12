-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set({ "n", "v", "i" }, "<M-w>", ":bd<MR>", {
--   desc = "Mlose buffer",
--   silent = true,
-- })

vim.keymap.set("i", "jj", "<Esc>", {
  noremap = true,
  silent = true,
  desc = "Exit insert mode with jj",
})
