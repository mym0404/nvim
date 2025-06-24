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
    open_fold_hl_timeout = 0,
    close_fold_kinds_for_ft = {
      default = { "imports" },
      typescript = { "imports" },
    },
    preview = {
      mappins = {
        default = {},
      },
    },
  },
}
