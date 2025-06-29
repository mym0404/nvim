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
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
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
        },
      },
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
    },
  },
}
