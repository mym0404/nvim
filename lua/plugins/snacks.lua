---@diagnostic disable: assign-type-mismatch
---@type snacks.picker.layout.Config
local vscode_layout = {
  preview = true,
  layout = {
    backdrop = true,
    row = 2,
    width = 0.60,
    min_width = 80,
    height = 0.8,
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
    { win = "list", border = "hpad", max_height = 15, focusable = true, height = 0.4 },
    {
      wrap = true,
      win = "preview",
      title = "{preview}",
      border = "rounded",
      focusable = true,
      height = 0.6,
    },
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
    indent = { enabled = true, priority = 1, only_current = true, only_scope = true },
    image = { enabled = false },
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
          win = {
            input = {
              keys = {
                ["<up>"] = { "history_back", mode = { "i", "n" } },
                ["<down>"] = { "history_forward", mode = { "i", "n" } },
                ["<esc>"] = { "close", mode = { "i", "n" } },
              },
            },
          },
        },
        grep = {
          exclude = common_exclude,
          hidden = true,
          ignored = false,
          layout = vscode_layout,
          win = {
            input = {
              keys = {
                ["<up>"] = { "history_back", mode = { "i", "n" } },
                ["<down>"] = { "history_forward", mode = { "i", "n" } },
                ["<esc>"] = { "close", mode = { "i", "n" } },
              },
            },
          },
        },
        explorer = {
          hidden = true,
          exclude = common_exclude,
          ignored = true,
          diagnostics = true,
          follow_file = false,
          git_status_open = false,
          confirm = true,
          auto_confirm = false,
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
          icons = {
            files = {
              enabled = true, -- show file icons
              dir = "󰉋 ",
              dir_open = "󰝰 ",
              file = "󰈔 ",
            },
            keymaps = {
              nowait = "󰓅 ",
            },
            tree = {
              vertical = "│ ",
              middle = "├╴",
              last = "└╴",
            },
            undo = {
              saved = " ",
            },
            ui = {
              live = "󰐰 ",
              hidden = "h",
              ignored = "i",
              follow = "f",
              selected = "● ",
              unselected = "○ ",
              -- selected = " ",
            },
            git = {
              enabled = true, -- show git icons
              commit = "󰜘 ", -- used by git log
              staged = "●", -- staged changes. always overrides the type icons
              unmerged = " ",
              renamed = "",
              untracked = "?",
              -- ignored = " ",
              -- added = "",
              -- deleted = "",
              -- modified = "○",
              ignored = "",
              added = "",
              deleted = "",
              modified = "",
            },
            diagnostics = {
              Error = " ",
              Warn = " ",
              Hint = " ",
              Info = " ",
            },
            lsp = {
              unavailable = "",
              enabled = " ",
              disabled = " ",
              attached = "󰖩 ",
            },
            kinds = {
              Array = " ",
              Boolean = "󰨙 ",
              Class = " ",
              Color = " ",
              Control = " ",
              Collapsed = " ",
              Constant = "󰏿 ",
              Constructor = " ",
              Copilot = " ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = " ",
              Folder = " ",
              Function = "󰊕 ",
              Interface = " ",
              Key = " ",
              Keyword = " ",
              Method = "󰊕 ",
              Module = " ",
              Namespace = "󰦮 ",
              Null = " ",
              Number = "󰎠 ",
              Object = " ",
              Operator = " ",
              Package = " ",
              Property = " ",
              Reference = " ",
              Snippet = "󱄽 ",
              String = " ",
              Struct = "󰆼 ",
              Text = " ",
              TypeParameter = " ",
              Unit = " ",
              Unknown = " ",
              Value = " ",
              Variable = "󰀫 ",
            },
          },
          formatters = {
            file = {
              filename_only = true,
              icon_width = 3,
              git_status_hl = true,
            },
            severity = {
              icons = true,
              level = false,
              pos = "right",
            },
          },
        },
      },
    },
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
███╗   ███╗     ██╗    ███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗
████╗ ████║     ██║    ██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗
██╔████╔██║     ██║    ███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║
██║╚██╔╝██║██   ██║    ╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║
██║ ╚═╝ ██║╚█████╔╝    ███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝
╚═╝     ╚═╝ ╚════╝     ╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
