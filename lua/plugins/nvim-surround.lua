return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert_line = "<C-g>S",
      insert = "<C-g>s",
      normal = "ms",
      normal_cur = "mss",
      normal_line = "mS",
      normal_cur_line = "mSS",
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
