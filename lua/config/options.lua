-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.ambiwidth = "single"
opt.autowrite = true
opt.swapfile = false
opt.conceallevel = 0

opt.iminsert = 0
opt.imsearch = 0

vim.opt.cindent = true
vim.opt.imsearch = 0
vim.opt.imsearch = 0

vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.exrc = true

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
vim.opt.termguicolors = true

vim.g.lazyvim_prettier_needs_config = true
-- vim.g.lazyvim_cmp = "nvim-cmp"
-- vim.g.snacks_animate = true
