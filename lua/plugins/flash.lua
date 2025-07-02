return {
  "folke/flash.nvim",
  lazy = false,
  priority = 1000,
  event = "VeryLazy",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    search = {
      multi_window = false,
    },
    jump = {
      pos = "end",
      autojump = false,
      offset = 0,
    },
    label = {
      after = true,
      before = false,
    },
    highlight = {
      backdrop = false,
      matches = true,
      priority = 9999,
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        backdrop = "FlashBackdrop",
        label = "FlashLabel",
        cursor = "FlashCursor",
      },
    },
    modes = {
      search = {},
      char = {
        highlight = { backdrop = false },
        keys = { "f", "F" },
        jump = { pos = "start" },
      },
      treesitter = {
        label = { after = true },
        jump = { pos = "range" },
      },
      treesitter_search = {
        jump = { pos = "range" },
        label = { after = true },
        search = { multi_window = false },
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "o", "x" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.keymap.set({ "o", "x" }, "T", function()
      require("flash").treesitter_search()
    end, { desc = "Treesitter Search" })
    vim.keymap.set({ "n", "x", "o" }, "t", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })
  end,
}
