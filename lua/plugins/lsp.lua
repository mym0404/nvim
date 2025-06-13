return {
  "neovim/nvim-lspconfig",
  opts = {
    autoformat = false,
  },
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.sourcekit.setup({
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP Actions",
      callback = function(args) end,
    })
  end,
}
