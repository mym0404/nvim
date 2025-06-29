local utils = require("utils/utils")
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      sourcekit = {
        enabled = utils.is_mac,
      },
      jdtls = {},
      kotlin_language_server = {},
      vtsls = {
        enabled = false,
      },
    },
  },
}
