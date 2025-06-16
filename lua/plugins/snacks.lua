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
    },
    { win = "list", border = "hpad", height = 7 },
    { win = "preview", title = "{preview}", border = "rounded" },
  },
}

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@module "snacks.nvim"
  ---@type snacks.Config
  opts = {
    indent = { enabled = false },
    ---@type snacks.explorer.Config
    explorer = {
      replace_netrw = true,
    },
    ---@type snacks.picker.Config
    picker = {
      hidden = true,
      -- ignored = true,
      sources = {
        grep = { layout = vscode_layout },
        git_grep = { layout = vscode_layout },
        notifications = { layout = vscode_layout },
        explorer = {
          hidden = true,
          layout = { auto_hide = { "input" }, preset = "sidebar" },
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
                  require("smart-splits").move_cursor_right({ at_edge = "stop" })
                end,
              },
            },
          },
        },
        files = {
          hidden = true,
          layout = vscode_layout,
          -- ignored = true,
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
