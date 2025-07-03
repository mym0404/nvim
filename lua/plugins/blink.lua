return {
  "saghen/blink.cmp",
  build = vim.g.lazyvim_blink_main and "cargo build --release",
  version = not vim.g.lazyvim_blink_main and "*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      optional = false, -- make optional so it's only enabled if any extras need it
      opts = {},
      -- version = not vim.g.lazyvim_blink_main and "*",
    },
    "Kaiser-Yang/blink-cmp-avante",
  },
  event = "InsertEnter",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "AvantePromptInput" }, vim.bo.filetype)
    end,
    keymap = {
      preset = "default",
      ["<tab>"] = {
        "snippet_forward",
        "accept",
        "fallback",
      },
      -- ["<s-tab>"] = { "accept", "fallback" },
      ["<CR>"] = {
        "accept",
        "fallback",
      },
    },
    cmdline = {
      enabled = true,
      keymap = {
        -- ["<tab>"] = { "select_next", "fallback" },
        -- ["<s-tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = {
          function()
            if vim.fn.getcmdtype() == ":" then
              local cmp = require("blink-cmp")
              if cmp.is_visible() then
                require("blink-cmp").accept_and_enter()
                return true
              end
              return false
            end
            return false
          end,
          "fallback",
        },
      },
      completion = { menu = { auto_show = true } },
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      -- kinds_icons = vim.tbl_extend(
      --   "force",
      --   opts.appearance.kind_icons or {},
      --   LazyVim.config.icons.kinds
      -- ),
    },
    completion = {
      trigger = { show_on_keyword = true },
      keyword = { range = "prefix" },
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = false,
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      menu = {
        draw = {
          padding = 1,
          gap = 1,
          treesitter = { "lsp" },
          columns = {
            { "kind_icon", gap = 1 },
            { "label", "label_description" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
              highlight = function(ctx)
                if ctx.kind:lower() == "copilot" then
                  return "Special"
                end
                return require("colorful-menu").blink_components_highlight(ctx)
                -- return { { group = ctx.kind_hl, priority = 20000 } }
              end,
            },
            -- label = {
            --   text = function(ctx)
            --     return require("colorful-menu").blink_components_text(ctx)
            --   end,
            -- highlight = function(ctx)
            --   return require("colorful-menu").blink_components_highlight(ctx)
            -- end,
            -- },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
        window = {
          scrollbar = true,
          border = "rounded",
          winblend = 0,
          desired_min_height = 30,
          max_height = 50,
        },

        treesitter_highlighting = true,
        draw = function(opts)
          ---@type fun(detail: string): string
          local function prettify_detail(detail)
            detail = detail or ""

            local result_lines = {}
            local in_code_block = false

            for line in detail:gmatch("([^\r\n]*)[\r\n]?") do
              local trimmed_line = line:gsub("^%s*(.-)%s*$", "%1")

              local code_block_index = trimmed_line:find("```")

              if code_block_index then
                in_code_block = not in_code_block

                if in_code_block then
                  local before = line:sub(1, code_block_index - 1)
                  local after = line:sub(code_block_index)

                  if before:match("%S") then
                    table.insert(result_lines, before)
                  end
                  table.insert(result_lines, after)
                else
                  table.insert(result_lines, line)
                end
              elseif in_code_block then
                table.insert(result_lines, line)
              else
                line = line:gsub("^%s*%(alias%)", "")
                line = line:gsub("^import.+$", "")
                line = line:gsub("^Auto import.+$", "")
                line = line:gsub("^%s*(.-)%s*$", "%1")
                table.insert(result_lines, line)
              end
            end

            while #result_lines > 0 and result_lines[1]:match("^%s*$") do
              table.remove(result_lines, 1)
            end

            while #result_lines > 0 and result_lines[#result_lines]:match("^%s*$") do
              table.remove(result_lines, #result_lines)
            end

            return table.concat(result_lines, "\n")
          end
          -- vim.notify(opts.item.documentation.value)
          -- vim.notify("prettied: " .. prettify_detail(opts.item.documentation.value))

          opts.default_implementation({
            detail = prettify_detail(opts.item.detail),
            documentation = opts.item.documentation == nil and nil
              or type(opts.item.documentation) == "string" and prettify_detail(
                opts.item.documentation
              )
              or {
                kind = opts.item.documentation.kind,
                value = prettify_detail(opts.item.documentation.value),
                -- value = opts.item.documentation.value,
              },
          })
        end,
      },
      ghost_text = {
        -- enabled = vim.g.ai_cmp,
        enabled = false,
      },
    },
    -- experimental signature help support
    signature = {
      enabled = true,
      window = { show_documentation = false, border = "rounded" },
    },

    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "avante", "lsp", "path", "snippets" },
      providers = {
        -- copilot = {
        --   name = "copilot",
        --   module = "blink-cmp-copilot",
        --   kind = "Copilot",
        --   score_offset = 100,
        --   async = true,
        -- },
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {},
        },
      },
    },
    snippets = {
      preset = "luasnip",
      -- expand = function(snippet)
      --   return LazyVim.cmp.expand(snippet)
      -- end,
    },
  },

  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    -- check if we need to override symbol kinds
    for _, provider in pairs(opts.sources.providers or {}) do
      ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        ---@diagnostic disable-next-line: no-unknown
        CompletionItemKind[provider.kind] = kind_idx

        ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
        local transform_items = provider.transform_items
        ---@param ctx blink.cmp.Context
        ---@param items blink.cmp.CompletionItem[]
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
            item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
          end
          return items
        end

        -- Unset custom prop to pass blink.cmp validation
        provider.kind = nil
      end
    end

    require("blink.cmp").setup(opts)
  end,
}
