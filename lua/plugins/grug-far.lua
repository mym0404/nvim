return {
  "MagicDuck/grug-far.nvim",
  opts = {
    helpLine = { enabled = false },
    showCompactInputs = true,
    showEngineInfo = false,
    transient = false,
    showInputsTopPadding = false,
    keymaps = {
      applyNext = { n = "<cr>" },
      nextInput = { n = "<tab>" },
      prevInput = { n = "<s-tab>" },
    },
    -- Use floating window
    windowCreationCommand = "tabnew",
    openTargetWindow = {
      preferredLocation = "right",
    },
  },
}
