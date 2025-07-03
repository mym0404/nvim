local utils = require("../utils/utils")

local function reset_keymaps()
  local reset_keys = {
    { "n", "gc" },
    { "n", "gco" },
    { "n", "gcO" },
    { "o", "gc" },
    { "n", "gcc" },
  }
  for _, key in ipairs(reset_keys) do
    pcall(vim.keymap.del, key[1], key[2])
  end
end

local function map_comments()
  local api = require("Comment.api")

  vim.keymap.set("n", "gc", api.toggle.linewise.current)

  -- local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

  -- vim.keymap.set("x", "gc", function()
  --   vim.api.nvim_feedkeys(esc, "nx", false)
  --   api.toggle.linewise(vim.fn.visualmode())
  -- end)
end

local function customizeExitInsertMode()
  for _, key in ipairs({ "jj", "jk", "kj", "ㅓㅏ", "ㅓㅓ" }) do
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
  vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without register" })
  -- vim.keymap.set({ "n", "v" }, "d", '"zd', { desc = "Delete without register" })
end

local function map_esc()
  vim.keymap.set("x", "q", "<Esc>", { silent = true, desc = "Exit visual mode with q" })
end

local function configure_git_diff()
  vim.keymap.set(
    "n",
    "<leader>z",
    "<cmd>DiffviewOpen<cr>",
    { silent = true, desc = "Open Diff View" }
  )
  vim.keymap.set(
    "n",
    "<leader>h",
    "<cmd>DiffviewFileHistory %<cr>",
    { silent = true, desc = "Open Diff view file history" }
  )
end

-- local function map_close_tap_or_buffer()
--   vim.keymap.set("n", "<C-w>", function()
--     local tab_count = vim.fn.tabpagenr("$")
--     if tab_count > 1 then
--       vim.cmd("tabclose")
--     else
--       vim.cmd("close")
--     end
--   end, {
--     desc = "Close tab if multiple tabs, else close buffer",
--   })
-- end

local function map_git_actions()
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
  end, { silent = true, desc = "Git discard current file changes" })

  vim.keymap.set("x", "<leader>gr", function()
    local start_line, end_line = utils.get_start_and_end_lines()
    local filepath = vim.fn.expand("%:p")

    if filepath == "" then
      print("No file to restore")
      return
    end

    local gs = require("gitsigns")
    -- utils.discard_changes_in_ran-- visual start~end 줄 번호 가져오기
    -- 해당 범위에 걸치는 모든 hunk reset
    gs.reset_hunk({ start_line, end_line })
    utils.go_to_normal_mode()
  end, { silent = true, desc = "Git restore selected lines" })
end

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
  end, { desc = "Delete current file", nowait = true })
end

local function map_enter()
  vim.keymap.set({ "n", "i" }, "<cr>", function()
    local prefix = vim.api.nvim_get_mode().mode == "n" and "i" or ""
    if utils.should_be_double_new_line() then
      return prefix .. "<cr><esc>O"
    end
    return prefix .. "<cr>"
  end, { expr = true, noremap = true, nowait = true, silent = true })
end

local function map_recording()
  vim.keymap.set("n", "q", "<Nop>")
  vim.keymap.set("n", "!", "qt", { desc = "start recording with register t" })
  vim.keymap.set("n", "@", "@t", { desc = "run recording with register t" })
end

local function map_smart_splits()
  local vertical_resize_amount = 3
  local horizontal_resize_amount = 5
  -- recommended mappings
  -- resizing splits
  -- these keymaps will also accept a range,
  -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
  vim.keymap.set({ "n", "t" }, "<A-h>", function()
    require("smart-splits").resize_left(horizontal_resize_amount)
  end)
  vim.keymap.set({ "n", "t" }, "<A-j>", function()
    require("smart-splits").resize_down(vertical_resize_amount)
  end)
  vim.keymap.set({ "n", "t" }, "<A-k>", function()
    require("smart-splits").resize_up(vertical_resize_amount)
  end)
  vim.keymap.set({ "n", "t" }, "<A-l>", function()
    require("smart-splits").resize_right(horizontal_resize_amount)
  end)

  -- moving between splits
  vim.keymap.set({ "i", "n", "t" }, "<C-h>", function()
    if vim.api.nvim_get_mode().mode == "i" then
      utils.go_to_normal_mode()
    end
    require("smart-splits").move_cursor_left({ at_edge = "stop" })
  end)
  vim.keymap.set({ "i", "n", "t" }, "<C-j>", function()
    if vim.api.nvim_get_mode().mode == "i" then
      utils.go_to_normal_mode()
    end
    require("smart-splits").move_cursor_down({ at_edge = "stop" })
  end)
  vim.keymap.set({ "i", "n", "t" }, "<C-k>", function()
    if vim.api.nvim_get_mode().mode == "i" then
      utils.go_to_normal_mode()
    end
    require("smart-splits").move_cursor_up({ at_edge = "stop" })
  end)
  vim.keymap.set({ "i", "n", "t" }, "<C-l>", function()
    if vim.api.nvim_get_mode().mode == "i" then
      utils.go_to_normal_mode()
    end
    require("smart-splits").move_cursor_right({ at_edge = "stop" })
  end)

  -- vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
  -- swapping buffers between windows
  -- vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
  -- vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
  -- vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
  -- vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
end

local function map_split()
  vim.keymap.set("n", "_", ":split<cr>", { desc = "split horizontal", nowait = true })
  vim.keymap.set("n", "|", ":vsplit<cr>", { desc = "split vertical", nowait = true })
end

local function map_select_all()
  vim.keymap.set("n", "<c-a>", "ggVG", { desc = "select all" })
end

local function map_shift_cr()
  vim.keymap.set("i", "<S-CR>", "<esc>o")
  vim.keymap.set("n", "<S-CR>", "i<esc>o")
end

local function map_docs_hover()
  vim.keymap.set("n", "<s-d>", function()
    vim.lsp.buf.hover()
  end, { desc = "hover documentation", silent = true })
end

local function map_scroll()
  vim.keymap.set("n", "<C-d>", function()
    vim.schedule(function()
      vim.cmd("normal! zz")
    end)
    return "<C-d>"
  end, { noremap = true, nowait = true, expr = true })

  vim.keymap.set("n", "<C-u>", function()
    vim.schedule(function()
      vim.cmd("normal! zz")
    end)
    return "<C-u>"
  end, { noremap = true, nowait = true, expr = true })
end

local function map_tstools()
  vim.keymap.set("n", "<leader>co", function()
    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
      require("typescript-tools.api").organize_imports(true)
    end
  end, { desc = "Organize Import" })

  vim.keymap.set("n", "<leader>cm", function()
    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
      require("typescript-tools.api").add_missing_imports(true)
    end
  end, { desc = "Add Missing Imports" })

  vim.keymap.set("n", "gs", function()
    if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
      require("typescript-tools.api").go_to_source_definition(true, { loclist = true })
    end
  end, { desc = "Go to Source with TSTool" })
end

local function map_package_info()
  vim.keymap.set(
    { "n" },
    "<LEADER>Ps",
    require("package-info").show,
    { silent = true, noremap = true, desc = "Show dependency versions" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pc",
    require("package-info").hide,
    { silent = true, noremap = true, desc = "Hide dependency versions" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pt",
    require("package-info").toggle,
    { silent = true, noremap = true, desc = "Toggle dependency versions" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pu",
    require("package-info").update,
    { silent = true, noremap = true, desc = "Update dependency on line" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pd",
    require("package-info").delete,
    { silent = true, noremap = true, desc = "Delete dependency on line" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pi",
    require("package-info").install,
    { silent = true, noremap = true, desc = "Install new dependency" }
  )

  vim.keymap.set(
    { "n" },
    "<LEADER>Pp",
    require("package-info").change_version,
    { silent = true, noremap = true, desc = "Change dependency version" }
  )
end

local function map_delete_buffer()
  vim.keymap.set("n", "<leader>w", function()
    utils.run_key("<leader>bd", "m")
  end, {})
end

local function map_react_prop_bracket()
  -- = to open curly brace
  vim.keymap.set("i", "=", function()
    if vim.bo.filetype ~= "typescriptreact" and vim.bo.filetype ~= "javascriptreact" then
      return "="
    end
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    if
      node ~= nil
      and (node:type() == "jsx_opening_element" or node:type() == "jsx_self_closing_element")
    then
      return "={}<esc>i"
    end
    return "="
  end, { nowait = true, expr = true })

  -- / to close tag
  vim.keymap.set("i", "/", function()
    if vim.bo.filetype ~= "typescriptreact" and vim.bo.filetype ~= "javascriptreact" then
      return "/"
    end
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    local _, col = utils.get_row_and_col()
    local line = vim.api.nvim_get_current_line()
    local next_char = line:sub(col + 1, col + 1)
    local left = line:sub(1, col)

    if not node then
      return "/"
    end

    if node ~= nil and node:has_error() and next_char ~= ">" and left:match(".*<[%w%d]+.*") then
      return "/>"
    end

    local tag_name = utils.get_jsx_name(node)
    local next_sibling = node:next_sibling()
    if
      node ~= nil
      and next_sibling ~= nil
      and tag_name ~= nil
      and node:type() == "jsx_opening_element"
      and next_char == ">"
      and tag_name == utils.get_jsx_name(node:next_sibling())
    then
      local start_row, start_col, end_row, end_col = next_sibling:range()
      vim.schedule(function()
        vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {})
      end)
      return "/"
    end

    return "/"
  end, { nowait = true, expr = true })
end

local function map_template_string()
  local Rule = require("nvim-autopairs.rule")
  local npairs = require("nvim-autopairs")
  local cond = require("nvim-autopairs.conds")
  local allowed_ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

  npairs.add_rule(
    Rule("{", "}", allowed_ft)
      :with_pair(cond.before_text("$"))
      :with_pair(cond.is_inside_quote())
      :replace_endpair(function(opts)
        local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
        if node == nil then
          return "}"
        end
        local string_node = (node ~= nil and node:type() == "string") and node
          or (
            (node ~= nil and node:parent() ~= nil and node:parent():type() == "string")
              and node:parent()
            or nil
          )
        if string_node ~= nil then
          local start_row, start_col, end_row, end_col = string_node:range()
          vim.schedule(function()
            vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, start_col + 1, { "`" })
            vim.api.nvim_buf_set_text(0, start_row, end_col, end_row, end_col + 2, { "`" })
          end)
          return "}"
        else
          return "}"
        end
      end)
  )
  -- press x1234 => x12341234
  npairs.add_rules({
    Rule("x%d%d%d%d$", "number", "lua"):use_regex(true):replace_endpair(function(opts)
      -- print(vim.inspect(opts))
      return opts.prev_char:sub(#opts.prev_char - 3, #opts.prev_char)
    end),
  })
end

local function map_close_bracket()
  vim.keymap.set("i", "}", function()
    if vim.bo.filetype == "swift" then
      require("conform").format({
        bufnr = vim.api.nvim_get_current_buf(),
        async = true,
        quiet = true,
      })
    end
    return "}"
  end, { expr = true, nowait = true, silent = true })
end

reset_keymaps()
map_template_string()
map_react_prop_bracket()
map_delete_buffer()
map_tstools()
map_docs_hover()
map_scroll()
map_shift_cr()
map_comments()
manipulate_yank_paste_register_behavior()
customizeExitInsertMode()
configure_git_diff()
map_esc()
-- map_close_tap_or_buffer()
map_rename()
map_delete_file()
map_enter()
map_recording()
map_split()
map_smart_splits()
map_select_all()
map_git_actions()
map_package_info()
map_close_bracket()
