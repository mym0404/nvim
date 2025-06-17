local M = {}

M.setup_sourcekit = function()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local capabilities = cmp_nvim_lsp.default_capabilities()

  local defaultLSPs = {
    "sourcekit",
  }

  for _, lsp in ipairs(defaultLSPs) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = lsp == "sourcekit" and { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) } or nil,
    })
  end
end
return M
