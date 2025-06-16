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

M.discard_changes_in_range = function(filepath, start_line, end_line)
  -- Get git root and relative path
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not in a git repository")
    return
  end

  local relative_path = vim.fn.fnamemodify(filepath, ":p"):gsub("^" .. git_root .. "/", "")

  -- Get original content from HEAD
  local original_lines =
    vim.fn.systemlist(string.format("git show HEAD:%s", vim.fn.shellescape(relative_path)))
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

return M
