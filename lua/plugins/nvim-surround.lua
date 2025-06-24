return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert_line = "<C-g>S",
      insert = "<C-g>s",
      normal = "m",
      normal_cur = "ms",
      normal_line = "mS",
      normal_cur_line = "mS",
      visual = "m",
      visual_line = "m",
      delete = "ds",
      change = "cs",
      change_line = "cS",
    },
    move_cursor = "sticky",
  },
}
