return {
  "sindrets/diffview.nvim",
  opts = {
    file_panel = {
      listing_style = "tree",
      win_config = {
        -- type = "float",
      },
      tree_options = {
        flatten_dirs = false,
      },
    },
    file_history_panel = {
      listing_style = "tree",
      win_config = {
        position = "left",
        height = 0,
        width = 35,
        win_opts = {},
      },
    },
  },
}
