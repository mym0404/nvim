return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = function()
    -- Conditionally use the correct build system for the current OS
    -- Determine the appropriate build command based on the operating system.
    local build_command
    if vim.fn.has("win32") == 1 then
      build_command = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      build_command = "make"
    end
    return build_command
  end,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  dependencies = {
    -- {
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
  },
  opts = {
    provider = "gemini",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.20,
          max_tokens = 300,
        },
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      gemini = {
        model = "gemini-2.5-flash",
        extra_request_body = {
          max_tokens = 300,
          temper,
        },
      },
    },
    hints = {
      enabled = false,
      submit_hint = false,
    },
    selector = {
      provider = "snacks",
      provider_opts = {},
    },
    input = {
      provider = "snacks",
      provider_opts = {
        title = "Avante Input",
      },
    },
    behaviour = {
      auto_set_highlight_group = false,
      auto_approve_tool_permissions = true,
    },
    windows = {
      sidebar_header = {
        enabled = false,
      },
      -- input = {
      --   prefix = "> ",
      --   height = 8,
      -- },
      ask = {
        floating = false,
      },
    },
    highlights = {
      diff = {
        current = "DiffDelete",
        imcoming = "DiffAdd",
      },
    },
    diff = {
      list_opener = "snacks",
    },
    mappings = {
      --- @class AvanteConflictMappings
      -- diff = {
      --   ours = "co",
      --   theirs = "ct",
      --   all_theirs = "ca",
      --   both = "cb",
      --   cursor = "cc",
      --   next = "]x",
      --   prev = "[x",
      -- },
      -- suggestion = {
      --   accept = "<M-l>",
      --   next = "<M-]>",
      --   prev = "<M-[>",
      --   dismiss = "<C-]>",
      -- },
      -- jump = {
      --   next = "]]",
      --   prev = "[[",
      -- },
      -- submit = {
      --   normal = { "<c-s>", "<CR>" },
      --   insert = { "<c-s>", "<CR>" },
      -- },
      -- cancel = {
      --   normal = { "<Esc>", "q" },
      --   insert = { "<Esc>" },
      -- },
      -- sidebar = {
      --   apply_all = "A",
      --   apply_cursor = "a",
      --   retry_user_request = "r",
      --   edit_user_request = "e",
      --   switch_windows = "<Tab>",
      --   reverse_switch_windows = "<S-Tab>",
      --   remove_file = "d",
      --   add_file = "@",
      --   close = { "<Esc>", "q" },
      --   close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
      -- },
      confirm = {
        focus_window = "<leader>aF",
      },
    },
  },
}
