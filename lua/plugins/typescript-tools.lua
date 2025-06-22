return {
  "pmizio/typescript-tools.nvim",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    settings = {
      separate_diagnostic_server = true,
      tsserver_format_options = {},
      tsserver_file_preferences = {
        "all",
      },
    },
  },
}
