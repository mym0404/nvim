return {
  "karb94/neoscroll.nvim",
  enabled = false,
  opts = {
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
    duration_multiplier = 0.3,
    -- post_hook = function()
    --   require("utils.utils").run_key("zz", "n")
    -- end,
    stop_eof = false,
  },
}
