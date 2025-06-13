---@diagnostic disable: need-check-nil

local utils = require("../utils/utils")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set({ "n", "v", "i" }, "<M-w>", ":bd<MR>", {
--   desc = "Mlose buffer",
--   silent = true,
-- })

-- Go back to normal mode with jj, jk, kj
for _, key in ipairs({ "jj", "jk", "kj" }) do
  vim.keymap.set({ "i" }, key, "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
end

-- Resize windows
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +3<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -3<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-Up>", "<cmd>resize +3<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -3<cr>", { desc = "Decrease window height" })

-- vim.keymap.set({ "n", "v" }, "y", '"ay', { desc = "Yank to register a" })
-- vim.keymap.set({ "n", "v" }, "p", '"ap', { desc = "Paste from register a" })
-- vim.keymap.set({ "n", "v" }, "P", '"aP', { desc = "Paste before from register a" })
-- vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete without register" })
-- vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without register" })

-- Quit visual mode with 'q'
vim.keymap.set("x", "q", "<Esc>", { noremap = true, silent = true, desc = "Exit visual mode with q" })

-- Move visual
vim.keymap.set("x", "<S-j>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
vim.keymap.set("x", "<S-k>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

vim.keymap.set("n", "<leader>z", "<cmd>DiffviewOpen<cr>", { noremap = true, silent = true, desc = "Open Diff View" })
vim.keymap.set(
  "n",
  "<leader>h",
  "<cmd>DiffviewFileHistory<cr>",
  { noremap = true, silent = true, desc = "Open Diff view file history" }
)

vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close tab" })

vim.keymap.set("n", "<CR>", "i<CR>", { desc = "New line on normal mode" })

vim.keymap.set("n", "<leader>gr", function()
  local filepath = vim.fn.expand("%")
  if filepath == "" then
    print("No file to restore")
    return
  end
  vim.cmd("silent !git restore " .. filepath)
  print("Discarded changes in " .. filepath)
  vim.cmd("edit!")
  -- vim.cmd("normal! <Esc>")
end, { noremap = true, silent = true, desc = "Git discard current file changes" })

vim.keymap.set("x", "<leader>gr", function()
  local start_line, end_line = utils.getStartAndEndLine()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    print("No file to restore")
    return
  end

  -- Get git root and relative path
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not in a git repository")
    return
  end

  local relative_path = vim.fn.fnamemodify(filepath, ":p"):gsub("^" .. git_root .. "/", "")

  -- Get original content from HEAD
  local original_lines = vim.fn.systemlist(string.format("git show HEAD:%s", vim.fn.shellescape(relative_path)))
  if vim.v.shell_error ~= 0 then
    print("Failed to get original content")
    return
  end

  -- Get current content
  local current_lines = vim.fn.getline(1, "$")

  -- Check if there are changes in selected range
  local has_changes = false
  for i = start_line, end_line do
    if current_lines[i] ~= (original_lines[i] or "") then
      has_changes = true
      break
    end
  end

  if not has_changes then
    print(string.format("No changes found in lines %d-%d", start_line, end_line))
    return
  end

  -- Replace selected lines with original content
  for i = start_line, end_line do
    if original_lines[i] then
      vim.fn.setline(i, original_lines[i])
    else
      -- If original file was shorter, delete the line
      vim.fn.setline(i, "")
    end
  end

  print(string.format("Restored lines %d to %d", start_line, end_line))
  utils.goToNormalMode()
end, { noremap = true, silent = true, desc = "Git restore selected lines" })
