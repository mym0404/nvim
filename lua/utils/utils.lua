M = {}

M.get_start_and_end_lines = function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  return start_line, end_line
end

M.go_to_normal_mode = function()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "n", false)
end

M.get_current_filetype = function()
  return vim.bo.filetype
end

M.get_row_and_col = function()
  return unpack(vim.api.nvim_win_get_cursor(0))
end

M.run_key = function(termcodes, mode)
  mode = mode or "m"
  local keys = vim.api.nvim_replace_termcodes(termcodes, true, false, true)
  vim.api.nvim_feedkeys(keys, mode, false)
end

M.get_current_cursor_char = function()
  local _, col = M.get_row_and_col()
  local line = vim.api.nvim_get_current_line()
  return line:sub(col + 1, col + 1)
end

local matching_pairs = {
  "{}",
  "[]",
  "()",
  "><",
}
M.is_in_pairs = function()
  local _, col = M.get_row_and_col()
  local line = vim.api.nvim_get_current_line()
  local left = line:sub(col, col)
  local right = line:sub(col + 1, col + 1)

  for _, pair in ipairs(matching_pairs) do
    if pair:sub(1, 1) == left and pair:sub(2, 2) == right then
      return true
    end
  end

  return false
end

M.is_in_explorer = function()
  local buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(buf)
  vim.notify(buf_name)
end

return M
