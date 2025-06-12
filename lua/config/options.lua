-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.ambiwidth = "single"
opt.autowrite = true
opt.swapfile = false

vim.g.lazyvim_prettier_needs_config = true
