return {
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("iceberg")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "iceberg",
    },
  },
}
