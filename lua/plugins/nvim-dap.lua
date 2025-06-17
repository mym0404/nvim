return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    lazy = false,
    config = function()
      vim.notify(1)
      local xcodebuild = require("xcodebuild.integrations.dap")
      -- SAMPLE PATH, change it to your local codelldb path
      local codelldbPath = os.getenv("HOME") .. "/tools/codelldb/extension/adapter/codelldb"
      vim.notify(codelldbPath)

      xcodebuild.setup(codelldbPath)

      vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
      vim.keymap.set(
        "n",
        "<leader>dr",
        xcodebuild.debug_without_build,
        { desc = "Debug Without Building" }
      )
      vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
      vim.keymap.set(
        "n",
        "<leader>dT",
        xcodebuild.debug_class_tests,
        { desc = "Debug Class Tests" }
      )
      vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set(
        "n",
        "<leader>B",
        xcodebuild.toggle_message_breakpoint,
        { desc = "Toggle Message Breakpoint" }
      )
      vim.keymap.set(
        "n",
        "<leader>dx",
        xcodebuild.terminate_session,
        { desc = "Terminate Debugger" }
      )
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
}
