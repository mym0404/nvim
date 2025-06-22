---@diagnostic disable: assign-type-mismatch
---@type snacks.picker.layout.Config
local vscode_layout = {
  preview = true,
  layout = {
    backdrop = true,
    row = 2,
    width = 0.5,
    min_width = 80,
    height = 0.7,
    border = "none",
    box = "vertical",
    {
      win = "input",
      height = 1,
      border = "rounded",
      title = "{title} {live} {flags}",
      title_pos = "center",
      focusable = true,
    },
    { win = "list", border = "hpad", height = 10, focusable = true },
    { wrap = true, win = "preview", title = "{preview}", border = "rounded", focusable = true },
  },
}

local common_exclude = { ".git", "~", ".idea", ".DS_Store" }

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@module "snacks.nvim"
  ---@type snacks.Config
  opts = {
    scroll = { enabled = false },
    indent = { enabled = false },
    ---@type snacks.explorer.Config
    explorer = {
      replace_netrw = false,
    },
    ---@type snacks.picker.Config
    picker = {
      hidden = true,
      -- ignored = true,
      sources = {
        notifications = { layout = vscode_layout },
        highlights = { layout = vscode_layout },
        files = {
          ignored = false,
          hidden = true,
          layout = vscode_layout,
          exclude = common_exclude,
        },
        grep = { exclude = common_exclude, hidden = true, ignored = false, layout = vscode_layout },
        explorer = {
          hidden = true,
          exclude = common_exclude,
          ignored = true,
          follow_file = false,
          layout = {
            layout = {
              backdrop = false,
              width = 35,
              min_width = 35,
              height = 0,
              enter = false,
              position = "left",
              border = "none",
              box = "vertical",
              -- {
              --   win = "input",
              --   height = 1,
              --   border = "rounded",
              --   title = "{title} {live} {flags}",
              --   title_pos = "center",
              -- },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
          win = {
            list = {
              keys = {
                ["<M-h>"] = function()
                  require("smart-splits").resize_left(5)
                end,
                ["<M-j>"] = function()
                  require("smart-splits").resize_down(3)
                end,
                ["<M-k>"] = function()
                  require("smart-splits").resize_up(3)
                end,
                ["<M-l>"] = function()
                  require("smart-splits").resize_right(5)
                end,
                ["<C-h>"] = function()
                  require("smart-splits").move_cursor_left({ at_edge = "stop" })
                end,
                ["<C-j>"] = function()
                  require("smart-splits").move_cursor_down({ at_edge = "stop" })
                end,
                ["<C-k>"] = function()
                  require("smart-splits").move_cursor_up({ at_edge = "stop" })
                end,
                ["<C-l>"] = function()
                  local wins = vim.api.nvim_list_wins()
                  local cur_win = vim.api.nvim_get_current_win()
                  -- for i, win in ipairs(wins) do
                  --   vim.notify(i .. ", " .. win)
                  -- end
                  -- vim.notify("cur win " .. cur_win)
                  local buf_id = vim.api.nvim_win_get_buf(cur_win)
                  local buf_name = vim.api.nvim_buf_get_name(buf_id)

                  local pickers = Snacks.picker.get({ source = "explorer" })
                  local is_explorer_visible = #pickers >= 1

                  if buf_name == "" and is_explorer_visible then
                    --    for _, win in ipairs(wins) do
                    --    local position = vim.api.nvim_win_get_position(win)
                    --    vim.notify("win: " .. win ..position)
                    ---   end
                    vim.api.nvim_set_current_win(wins[1])
                  else
                    require("smart-splits").move_cursor_right({ at_edge = "stop" })
                  end
                  -- vim.notify("buf_name " .. buf_name)
                end,
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<F1>",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "Reveal in explorer",
    },
  },
}
