return {
  "wojciech-kulik/xcodebuild.nvim",
  enabled = require("utils/utils").is_mac,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "stevearc/oil.nvim", -- (optional) to manage project files
  },
  opts = {
    integrations = {
      pymobiledevice = {
        enabled = true,
      },
    },
  },
}
