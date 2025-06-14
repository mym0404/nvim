local M = {}

M.setup_sourcekit = function()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local keymap = vim.keymap -- for conciseness
  local opts = { noremap = true, silent = true }
  local on_attach = function(_, bufnr)
    opts.buffer = bufnr

    -- set keybindings
    -- opts.desc = "Show LSP definitions"
    -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions trim_text=true<cr>", opts)
    --
    -- opts.desc = "Show LSP definitions in split"
    -- keymap.set("n", "gD", "<cmd>vsplit | Telescope lsp_definitions trim_text=true<cr>", opts)
    --
    -- opts.desc = "Show LSP references"
    -- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references trim_text=true include_declaration=false<cr>", opts)
    --
    -- opts.desc = "Show LSP implementation"
    -- vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
    --
    -- opts.desc = "Show LSP code actions"
    -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    --
    -- opts.desc = "Smart rename"
    -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    --
    -- opts.desc = "Show buffer diagnostics"
    -- keymap.set("n", "<leader><leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
    --
    -- opts.desc = "Go to previous diagnostic"
    -- keymap.set("n", "[d", function()
    --   vim.diagnostic.jump({ count = -1 })
    --   vim.cmd("normal! zz")
    -- end, opts)
    --
    -- opts.desc = "Go to next diagnostic"
    -- keymap.set("n", "]d", function()
    --   vim.diagnostic.jump({ count = 1 })
    --   vim.cmd("normal! zz")
    -- end, opts)
    --
    -- opts.desc = "Show documentation for what is under cursor"
    -- keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --
    -- opts.desc = "Restart LSP"
    -- keymap.set("n", "<leader>rl", ":LspRestart | LspStart<CR>", opts)
  end

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

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
end
return M
