return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  -- keys = {
  --
  --     bu{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  --   { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
  --   { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
  --   { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
  --   { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
  --   { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  -- },
  opts = {
    options = {
      style_preset = require("bufferline").style_preset.minimal,
      numbers = "none",
      truncate_names = false,
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      always_show_bufferline = true,
      tab_size = 18,
      indicator = {
        style = "icon",
        icon = "▎",
      },
      color_icons = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        return ""
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      separator_style = { "", "" },
    },
  },
  -- config = function(_, opts)
  --   require("bufferline").setup(opts)
  --   -- Fix bufferline when restoring a session
  --   vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  --     callback = function()
  --       vim.schedule(function()
  --         pcall(nvim_bufferline)
  --       end)
  --     end,
  --   })
  -- end,
}
