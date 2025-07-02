---@diagnostic disable: assign-type-mismatch
---@type snacks.picker.layout.Config
local vscode_layout_preview = {
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
      border = "rounded",
      title = "{title} {live} {flags}",
      title_pos = "center",
      focusable = true,
    },
    { win = "list", border = "rounded", max_height = 15, focusable = true, height = 0.4 },
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
---@diagnostic disable: assign-type-mismatch
---@type snacks.picker.layout.Config
local vscode_layout_without_preview = {
  preview = false,
  layout = {
    backdrop = true,
    row = 2,
    width = 0.50,
    min_width = 60,
    height = 0.7,
    max_height = 35,
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
    { win = "list", border = "rounded", focusable = true },
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
    ---@type table<string, snacks.win.Config>
    styles = {
      -- input = {
      --   title_pos = "left",
      --   height = 1,
      --   width = 60,
      -- },
      notification = {
        border = "solid",
        wo = {
          wrap = true,
        },
      },
      notification_history = {
        title_pos = "left",
        wo = {
          wrap = true,
        },
      },
      lazygit = { wo = {} },
    },
    terminal = {
      shell = "zsh",
      win = {},
    },
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 45, max = 0.6 },
      height = { min = 1, max = 0.6 },
      sort = { "added", "level" },
      ---@type snacks.notifier.style
      style = "fancy",
    },
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
        notifications = { layout = vscode_layout_preview },
        highlights = { layout = vscode_layout_preview },
        files = {
          ignored = false,
          hidden = true,
          layout = vscode_layout_without_preview,
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
        select = {
          layout = {
            preview = true,
            -- preset = "dropdown",
            layout = {
              backdrop = false,
              -- row = 3,
              -- col = 1,
              width = 0.4,
              min_width = 40,
              height = 0.4,
              min_height = 3,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        grep = {
          exclude = common_exclude,
          hidden = true,
          ignored = false,
          layout = vscode_layout_preview,
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
              width = 42,
              min_width = 42,
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
        },
      },
      sort = {},
      matcher = {
        history_bonus = true,
        frecency = true,
        cwd_bonus = true,
        sort_empty = true,
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 100,
          icon_width = 3,
        },
        severity = {
          icons = true,
          level = false,
          pos = "right",
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
      "<leader>/",
      function()
        local root = vim.fs.root(0, { ".git" })
        Snacks.picker.grep({
          ignored = false,
          title = "Search Text",
          cwd = root,
          enter = true,
        })
      end,
      desc = "Search Text",
    },
    {
      "<leader><space>",
      function()
        local root = vim.fs.root(0, { ".git" })
        Snacks.picker.files({
          ignored = false,
          title = "Files",
          cwd = root,
          enter = true,
          -- format = Snacks.picker.format.file,
          --items = vim.tbl_map(function(path)
          --   return {
          --     -- item.name: 첫 번째 컬럼 (파일명)
          --     name = vim.fn.fnamemodify(path, ":t"),
          --     -- item.text: 두 번째 컬럼 (상대경로)
          --     text = vim.fn.fnamemodify(path, ":h"),
          --     -- 전체 경로(열었을 때 사용할 값)
          --     full = vim.fn.getcwd() .. "/" .. path,
          --   }
          -- end, files),
        })
      end,
      desc = "Find Files",
    },
    {
      "<leader>e",
      function()
        local root = vim.fs.root(0, { ".git" })
        Snacks.picker.explorer({
          enter = false,
          cwd = root,
          ignored = true,
          hidden = true,
          follow_file = false,
        })
      end,
      desc = "Open Explorer",
    },
    {
      "<F1>",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "Reveal in explorer",
    },
  },
}
