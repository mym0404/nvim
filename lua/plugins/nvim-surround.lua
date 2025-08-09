return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert_line = "<C-g>S",
      insert = "<C-g>s",
      normal = "t",
      normal_cur = "ts",
      normal_line = "tS",
      normal_cur_line = "tS",
      visual = "t",
      -- visual_line = "t",
      delete = "ds",
      change = "cs",
      change_line = "cS",
    },
    move_cursor = "sticky",
  },
}
