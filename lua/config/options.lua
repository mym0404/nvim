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
opt.termguicolors = true
opt.list = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.iminsert = 0
opt.imsearch = 0

opt.guicursor =
  "n-v-c-sm:block-blinkwait1000-blinkon500-blinkoff500,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
-- opt.tabstop = 2
-- opt.shiftwidth = 8

opt.imsearch = 0
opt.imsearch = 0

-- opt.mouse = ""
-- vim.o.mousemodel = "extend"
opt.showmode = false
opt.exrc = true

vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

vim.g.lazyvim_prettier_needs_config = true
-- vim.g.lazyvim_cmp = "nvim-cmp"
-- vim.g.snacks_animate = false

-- opt.foldmethod = "manual"
-- opt.foldexpr = nil
opt.foldcolumn = "1"
opt.foldlevel = 99
-- opt.foldtext = "v:lua.require'ufo.main'.foldtext()"
-- opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
opt.foldlevelstart = 99
opt.foldenable = true

opt.laststatus = 3
vim.o.winborder = "rounded"

vim.g.ai_cmp = false
vim.g.vim_json_conceal = 0
