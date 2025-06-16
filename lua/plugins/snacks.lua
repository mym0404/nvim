return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = { enabled = false },
    explorer = {
      position = "left",
      width = 22,
      ignored = true,
      hidden = true,
      replace_netrw = true,
    },
    picker = {
      hidden = true,
      -- ignored = true,
      sources = {
        explorer = {
          layout = {
            auto_hide = { "input" },
          },
        },
        files = {
          hidden = true,
          -- ignored = true,
        },
      },
      explorer = {
        win = {
          list = {
            keys = {
              ["<F1>"] = "explorer_rename",
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
