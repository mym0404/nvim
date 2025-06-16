local utils = require("../utils/utils")

local function reset_keymaps()
  local reset_keys = {
    { "n", "gc" },
    { "n", "gco" },
    { "n", "gcO" },
    { "o", "gc" },
    { "x", "gc" },
    { "n", "gcc" },
  }
  for _, key in ipairs(reset_keys) do
    pcall(vim.keymap.del, key[1], key[2])
  end
end

local function setup_comments()
  local api = require("Comment.api")

  vim.keymap.set("n", "gc", api.toggle.linewise.current)

  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

  vim.keymap.set("x", "gc", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.toggle.linewise(vim.fn.visualmode())
  end)
end

local function customizeExitInsertMode()
  for _, key in ipairs({ "jj", "jk", "kj" }) do
    vim.keymap.set(
      { "i" },
      key,
      "<Esc>",
      { noremap = true, silent = true, desc = "Exit insert mode" }
    )
  end
end

local function manipulate_yank_paste_register_behavior()
  -- vim.keymap.set({ "n", "v" }, "y", '"zy', { desc = "Yank to register a" })
  -- vim.keymap.set({ "n", "v" }, "p", '"zp', { desc = "Paste from register a" })
  -- vim.keymap.set(
  --   { "n", "v" },
  --   "P",
  --   '"zP',
  --   { desc = "Paste before from register a" }
  -- )
  vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete without register" })
  -- vim.keymap.set({ "n", "v" }, "d", '"zd', { desc = "Delete without register" })
end

local function map_resize_windows()
  -- Resize windows
  vim.keymap.set(
    "n",
    "<S-Right>",
    "<cmd>vertical resize +3<cr>",
    { desc = "Increase window width" }
  )
  vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -3<cr>", { desc = "Decrease window width" })
  vim.keymap.set("n", "<S-Up>", "<cmd>resize +3<cr>", { desc = "Increase window height" })
  vim.keymap.set("n", "<S-Down>", "<cmd>resize -3<cr>", { desc = "Decrease window height" })
end

local function map_close_visual()
  vim.keymap.set(
    "x",
    "q",
    "<Esc>",
    { noremap = true, silent = true, desc = "Exit visual mode with q" }
  )
end

local function map_move_vline()
  -- Move visual
  vim.keymap.set(
    "x",
    "<S-j>",
    ":move '>+1<CR>gv=gv",
    { noremap = true, silent = true, desc = "Move selection down" }
  )
  vim.keymap.set(
    "x",
    "<S-k>",
    ":move '<-2<CR>gv=gv",
    { noremap = true, silent = true, desc = "Move selection up" }
  )
end
local function configure_git_diff()
  vim.keymap.set(
    "n",
    "<leader>z",
    "<cmd>DiffviewOpen<cr>",
    { noremap = true, silent = true, desc = "Open Diff View" }
  )
  vim.keymap.set(
    "n",
    "<leader>h",
    "<cmd>DiffviewFileHistory %<cr>",
    { noremap = true, silent = true, desc = "Open Diff view file history" }
  )
end

local function map_close_tap_or_buffer()
  vim.keymap.set("n", "<C-w>", function()
    local tab_count = vim.fn.tabpagenr("$")
    if tab_count > 1 then
      vim.cmd("tabclose")
    else
      vim.cmd("bdelete")
    end
  end, {
    noremap = true,
    silent = true,
    desc = "Close tab if multiple tabs, else close buffer",
  })
end

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
  local start_line, end_line = utils.get_start_and_end_lines()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    print("No file to restore")
    return
  end

  utils.discard_changes_in_range(filepath, start_line, end_line)

  utils.go_to_normal_mode()
end, { noremap = true, silent = true, desc = "Git restore selected lines" })

local function map_rename()
  vim.keymap.set("n", "<F6>", function()
    utils.run_key(":IncRename ", "n")
  end, { desc = "Rename file" })
end

local function map_delete_file()
  vim.keymap.set("n", "<space>cd", function()
    local current_buffer_file_path = vim.api.nvim_buf_get_name(0)
    vim.cmd("bdelete")
    vim.cmd("!rm " .. current_buffer_file_path)
    vim.notify("Delete file " .. current_buffer_file_path)
  end, { desc = "Delete current file" })
end

local function map_enter()
  vim.keymap.set("i", "<cr>", function()
    if utils.is_in_pairs() then
      return "<cr><esc>O"
    end
    return "<cr>"
  end, { expr = true })
end

reset_keymaps()
setup_comments()
manipulate_yank_paste_register_behavior()
customizeExitInsertMode()
configure_git_diff()
map_resize_windows()
map_close_visual()
map_move_vline()
map_close_tap_or_buffer()
map_rename()
map_delete_file()
map_enter()
