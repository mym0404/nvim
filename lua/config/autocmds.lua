-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local utils = require("utils/utils")

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

local function map_searches()
  local root = vim.fs.root(0, { ".git" })
  vim.keymap.set("n", "<leader>/", function()
    Snacks.picker.grep({ ignored = false, title = "Search Grep Anywhere", cwd = root, enter = true })
  end, { nowait = true, noremap = true, desc = "git grep" })
  vim.keymap.set("n", "<leader> ", function()
    Snacks.picker.files({ ignored = false, title = "Search Anywhere", cwd = root, enter = true })
  end, { nowait = true, noremap = true, desc = "git files" })
  vim.keymap.set("n", "<leader>e", function()
    Snacks.picker.explorer({
      enter = false,
      cwd = root,
      ignored = true,
      hidden = true,
      follow_file = false,
    })
  end, { desc = "Open Explorer" })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function(event)
    map_searches()
  end,
})

--                                                         *lsp-defaults-disable*
-- To override or delete any of the above defaults, set or unset the options on
-- |LspAttach|: >lua

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- Move visual
    vim.keymap.set(
      "x",
      "<s-j>",
      ":move '>+1<CR>gv=gv",
      { silent = true, desc = "Move selection down", buffer = args.buf }
    )
    vim.keymap.set(
      "x",
      "<s-k>",
      ":move '<-2<CR>gv=gv",
      { silent = true, desc = "Move selection up", buffer = args.buf }
    )
    vim.keymap.set(
      "n",
      "<s-k>",
      ":m .-2<CR>==",
      { noremap = true, silent = true, buffer = args.buf }
    )
    vim.keymap.set(
      "n",
      "<s-j>",
      ":m .+1<CR>==",
      { noremap = true, silent = true, buffer = args.buf }
    )
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    if utils.is_js_ft() then
      require("typescript-tools.api").remove_unused_imports()
    end
  end,
})

vim.api.nvim_create_autocmd("LspNotify", {
  callback = function(opts)
    if opts.data.method == "textDocument/didOpen" and utils.is_js_ft() then
      local firstLine = vim.api.nvim_buf_get_lines(0, 1, 2, false)
      if #firstLine >= 1 and firstLine[1]:match("^import ") then
        vim.cmd("1,1foldclose")
      end
    end
  end,
})

-- local function set_english_input()
-- vim.defer_fn(function()
-- vim.fn.system("macism com.apple.keylayout.ABC")
-- vim.fn.system("macism com.apple.keylayout.US")
-- end, 100)
-- end

-- brew tap laishulu/homebrew
-- brew install macism
-- vim.api.nvim_create_autocmd({ "InsertLeave", "FocusGained", "ModeChanged" }, {
--   callback = function(event)
--     if event.event == "InsertLeave" then
--       set_english_input()
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
