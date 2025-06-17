return {
  "folke/flash.nvim",
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
    },
    label = {
      after = false,
      before = true,
    },
    highlight = {
      -- backdrop = false,
    },
    modes = {
      char = {
        keys = { "f", "F" },
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n" },
      function()
        vim.notify("hello", vim.log.levels.WARN, {})
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
