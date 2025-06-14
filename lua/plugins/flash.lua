return {
  "folke/flash.nvim",
  enable = true,
  event = "VeryLazy",
  ---@type Flash.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "t", mode = { "o", "x"}, function() require("flash").treesitter_search() end, desc = "Treesitter Search"},
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.keymap.set({ "o", "x" }, "t", function()
      require("flash").treesitter_search()
    end, { desc = "Treesitter Search" })
    vim.keymap.set({ "n", "x", "o" }, "T", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })
  end,
}
