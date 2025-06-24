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

local js_fts = {
  "javascript",
  "typescript",
  "typescriptreact",
  "javascriptreact",
}

local double_new_line_files = {
  "lua",
  "swift",
  "kotlin",
  "java",
  "html",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}
local matching_pairs = {
  "{}",
  "[]",
  "()",
  "><",
}
M.should_be_double_new_line = function()
  local ft = vim.bo.filetype
  local is_valid_ft = false
  for _, check_ft in ipairs(double_new_line_files) do
    if ft == check_ft then
      is_valid_ft = true
      break
    end
  end

  if not is_valid_ft then
    return false
  end

  -- check is inside between pair
  local _, col = M.get_row_and_col()
  local line = vim.api.nvim_get_current_line()
  local left = line:sub(col, col)
  local right = line:sub(col + 1, col + 1)

  for _, pair in ipairs(matching_pairs) do
    if pair:sub(1, 1) == left and pair:sub(2, 2) == right then
      return true
    end
  end

  -- check is lua function start
  if ft == "lua" then
    local left_str = line:sub(1, col)
    local right_str = line:sub(col + 1)
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    if
      left_str:match("function")
      and right_str:match("end")
      and node ~= nil
      and node:type() == "function_definition"
    then
      return true
    end
  end

  return false
end

M.should_close_slash_in_tag = function()
  -- <br "/">
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local left = line:sub(1, col)
  if left:match(".*<[%w%d]") then
    return true
  end
  return false
end

--- @param str string
M.to_str_list = function(str)
  local ret = {}
  for line in str:gmatch("[^\r\n]+") do
    table.insert(ret, line)
  end
  return ret
end

M.get_jsx_name = function(node)
  local n = node
  if
    n == nil
    or not (
      n:type() == "jsx_opening_element"
      or n:type() == "jsx_closing_element"
      or n:type() == "jsx_self_closing_element"
    )
  then
    return nil
  end

  local name_node = n:field("name")[1]
  if not name_node then
    return nil
  end

  return vim.treesitter.get_node_text(name_node, 0)
end

M.is_js_ft = function(buf)
  buf = buf or 0
  for _, ft in ipairs(js_fts) do
    if vim.bo[buf].filetype == ft then
      return true
    end
  end
  return false
end

return M
