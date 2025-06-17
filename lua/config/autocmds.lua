-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
  desc = "Disable auto comment continuation",
})

local function set_english_input()
  -- vim.defer_fn(function()
  --   vim.fn.system("macism com.apple.keylayout.ABC")
  --   vim.fn.system("macism com.apple.keylayout.US")
  -- end, 100)
end

-- brew tap laishulu/homebrew
-- brew install macism
-- vim.api.nvim_create_autocmd({ "InsertLeave", "FocusGained", "ModeChanged" }, {
--   callback = function(event)
--     if event.event == "InsertLeave" then
--       -- set_english_input()
--     elseif event.event == "ModeChanged" then
--       local mode_change = vim.fn.mode()
--       if mode_change == "n" then
--         set_english_input()
--       end
--     elseif event.event == "FocusGained" and vim.fn.mode() ~= "i" then
--       set_english_input()
--     end
--   end,
-- })

local function map_searches()
  vim.keymap.set("n", "<S-f>", function()
    Snacks.picker.files()
  end)
  vim.keymap.set("n", "<S-p>", function()
    Snacks.picker.grep()
  end, { nowait = true, noremap = true })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function(event)
    map_searches()
  end,
})
