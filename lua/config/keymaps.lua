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

-- vim.keymap.set("n", "<leader>gr", function()
--   local filepath = vim.fn.expand("%")
--   if filepath == "" then
--     print("No file to restore")
--     return
--   end
--   -- 저장되지 않은 변경사항 모두 git restore 로 되돌리기
--   vim.cmd("silent !git restore " .. filepath)
--   print("Discarded changes in " .. filepath)
--   -- 버퍼 다시 읽기
--   vim.cmd("edit!")
-- end, { noremap = true, silent = true, desc = "Git discard current file changes" })

vim.keymap.set("x", "<leader>gr", function()
  -- 선택된 줄 범위 가져오기
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- 현재 파일 경로
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    print("No file to restore")
    return
  end

  -- 선택된 줄들만 git restore 하기 위해 patch 생성 후 적용 (임시 파일 필요)
  local cmd =
    string.format("git checkout HEAD -- %s && git restore -p %s -L %d,%d", filepath, filepath, start_line, end_line)

  -- 시스템 명령 실행
  local result = vim.fn.system(cmd)

  -- 버퍼 다시 읽기
  vim.cmd("edit!")

  print("Discarded changes in lines " .. start_line .. " to " .. end_line)
end, { noremap = true, silent = true, desc = "Git discard selected lines" })
