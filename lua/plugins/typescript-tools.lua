return {
  "pmizio/typescript-tools.nvim",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    settings = {
      separate_diagnostic_server = true,
      tsserver_format_options = {},
      expose_as_code_action = {
        "fix_all",
        "add_missing_imports",
        "remove_unused",
        "remove_unused_imports",
        "organize_imports",
      },
      tsserver_file_preferences = {
        quotePreference = "single",
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
      },
    },
  },
}
