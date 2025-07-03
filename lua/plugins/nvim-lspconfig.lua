local utils = require("utils/utils")
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    inlay_hints = { enabled = true },
    servers = {
      sourcekit = {
        enabled = utils.is_mac,
      },
      jdtls = {},
      kotlin_language_server = {},
      vtsls = {
        enabled = false,
      },
      marksman = {
        filetypes = { "markdown", "markdown.mdx" },
      },
    },
    setup = {
      ["*"] = function(server, _)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig[server].setup({ capabilities = capabilities })
      end,
    },
  },
}
