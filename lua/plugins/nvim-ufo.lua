return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "LspNotify",
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
    },
    -- {
    --   "<c-o>",
    --   function()
    --     local winid = require("ufo").peekFoldedLinesUnderCursor()
    --     if not winid then
    --       vim.lsp.buf.hover()
    --     end
    --   end,
    -- },
  },
  opts = {
    close_fold_kinds_for_ft = {
      default = { "imports", "region" },
      typescript = { "imports", "region" },
    },
  },
}
