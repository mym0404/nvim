return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert_line = "<C-g>S",
      insert = "<C-g>s",
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "S",
      delete = "ds",
      change = "cs",
      change_line = "cS",
    },
    move_cursor = "sticky",
  },
}

--  <((asdㅛㄴasd))>
