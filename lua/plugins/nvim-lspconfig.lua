local utils = require("utils/utils")

require("lspconfig.configs").biome2 = {
  default_config = {
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
      "astro",
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "svelte",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
      "vue",
    },
    root_dir = function(fname)
      local ret =
        require("lspconfig.util").root_pattern("biome.json", "biome.jsonc", "package.json")(fname)
      return ret
    end,
    workspace_required = true,
    single_file_support = true,
    settings = {},
  },
}
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    inlay_hints = { enabled = true },
    servers = {
      sourcekit = {
        enabled = utils.is_mac,
        settings = {},
      },
      jdtls = {},
      biome = {
        enabled = false,
      },
      kotlin_language_server = {},
      vtsls = {
        enabled = true,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            preferences = {
              importModuleSpecifierPreference = "relative",
              jsxAttributeCompletionStyle = "braces",
              quotePreference = "single",
              includeCompletionsForModuleExports = true,
              importModuleSpecifierEnding = "auto",
            },
          },
        },
      },
      marksman = {
        filetypes = { "markdown", "markdown.mdx" },
        -- on_attach = function(client, bufnr)
        --   -- Disable diagnostics for markdown files
        --   vim.diagnostic.enable(false, { bufnr = bufnr })
        -- end,
      },
      biome2 = {},
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
