return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    indent = { enabled = false },
    explorer = {
      position = "left",
      width = 25,
    },
    picker = {
      hidden = true,
      -- ignored = true,
      sources = {
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
