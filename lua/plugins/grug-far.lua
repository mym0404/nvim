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
    windowCreationCommand = "lua require('nui.popup')({ enter = true, focusable = true, border = { style = 'rounded' }, position = '50%', size = { width = '90%', height = '80%' } }):mount()",
  },
}
