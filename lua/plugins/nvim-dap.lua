local utils = require("utils/utils")
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    enabled = utils.is_mac,
    lazy = false,
    config = function()
      local xcodebuild = require("xcodebuild.integrations.dap")
      local codelldbPath = os.getenv("HOME") .. "/tools/codelldb/extension/adapter/codelldb"

      xcodebuild.setup(codelldbPath)

      vim.keymap.set("n", "<leader>Xd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
      vim.keymap.set(
        "n",
        "<leader>dr",
        xcodebuild.debug_without_build,
        { desc = "Debug Without Building" }
      )
      vim.keymap.set("n", "<leader>Xt", xcodebuild.debug_tests, { desc = "Debug Tests" })
      vim.keymap.set("n", "<leader>Xp", ":XcodebuildPicker<cr>", { desc = "Debug Tests" })
      vim.keymap.set(
        "n",
        "<leader>XT",
        xcodebuild.debug_class_tests,
        { desc = "Debug Class Tests" }
      )
      vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      -- vim.keymap.set(
      --   "n",
      --   "<leader>B",
      --   xcodebuild.toggle_message_breakpoint,
      --   { desc = "Toggle Message Breakpoint" }
      -- )
      vim.keymap.set(
        "n",
        "<leader>Xx",
        xcodebuild.terminate_session,
        { desc = "Terminate Debugger" }
      )
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        -- {
        --   elements = {
        --     {
        --       id = "scopes",
        --       size = 0.25,
        --       enter = false,
        --     },
        --     {
        --       id = "breakpoints",
        --       size = 0.25,
        --       enter = false,
        --     },
        --     {
        --       id = "stacks",
        --       size = 0.25,
        --       enter = false,
        --     },
        --     {
        --       id = "watches",
        --       size = 0.25,
        --       enter = false,
        --     },
        --   },
        --   position = "left",
        --   size = 40,
        -- },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
  },
}
