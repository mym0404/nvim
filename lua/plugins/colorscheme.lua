return {
  -- { "ellisonleao/gruvbox.nvim" },
  -- {
  --   "cocopon/iceberg.vim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("iceberg")
  --   end,
  -- },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("github-theme").setup({
    --     theme_style = "dark_dimmed",
    --   })
    --   -- vim.cmd("colorscheme github_dark_dimmed")
    -- end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_default",
    },
  },
}
