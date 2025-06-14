-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = true
local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.ambiwidth = "single"
opt.autowrite = true
opt.swapfile = false
opt.conceallevel = 0

vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_cmp = "nvim-cmp"

vim.o.mouse = "a"
vim.o.showmode = false
vim.o.exrc = true

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.hl.on_yank()
  end,
})
vim.o.termguicolors = true
