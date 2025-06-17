-- if true then
--   return {}
-- end
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      sourcekit = {},
    },
  },
  -- config = function()
  --   vim.notify(1)
  -- require("../utils/sourcekit_lsp").setup_sourcekit()
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.posi:tionEncodings = { "utf-16" }
  -- end,
}
