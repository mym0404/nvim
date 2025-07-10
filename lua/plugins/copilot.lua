-- vim.api.nvim_create_autocmd("User", {
--   pattern = "BlinkCmpMenuOpen",
--   callback = function()
--     -- require("copilot.suggestion").dismiss()
--     vim.b.copilot_suggestion_hidden = true
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "BlinkCmpMenuClose",
--   callback = function()
--     vim.b.copilot_suggestion_hidden = false
--   end,
-- })

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      debounce = 50,

      hide_during_completion = false,

      keymap = {
        accept = "<c-.>",
        next = "<c-]>",
        prev = "<c-[>",
      },
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
      yaml = true,
    },
  },
}
