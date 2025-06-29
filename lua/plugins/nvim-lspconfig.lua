return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      sourcekit = {},
      jdtls = {},
      kotlin_language_server = {},
      vtsls = {
        enabled = false,
      },
    },
  },
}
