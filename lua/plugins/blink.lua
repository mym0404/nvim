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
          enabled = true,
        },
      },
      list = {
        max_items = 50,
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
            { "label", "label_description", gap = 3, "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon .. " "
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            label = {
              width = { fill = true, max = 30 },
              text = function(ctx)
                local highlights_info = require("colorful-menu").blink_highlights(ctx)
                if highlights_info ~= nil then
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              -- highlight = function(ctx)
              --   local highlights = {}
              --   local highlights_info = require("colorful-menu").blink_highlights(ctx)
              --   if highlights_info ~= nil then
              --     highlights = highlights_info.highlights
              --   end
              --   for _, idx in ipairs(ctx.label_matched_indices) do
              --     table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
              --   end
              --   -- Do something else
              --   return highlights
              -- end,
            },
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
          desired_min_height = 60,
          max_height = 60,
          min_width = 40,
          max_width = 70,
          desired_min_width = 40,
        },

        treesitter_highlighting = true,
        draw = function(opts)
          local docs = require("utils/docs")
          ---@type fun(detail: string, opts: any): string

          -- vim.notify(opts.item.documentation.value)
          -- vim.notify("prettied: " .. prettify_detail(opts.item.documentation.value))

          -- vim.notify(vim.bo[opts.window.buf].filetype)
          -- vim.notify(opts.item.detail)
          opts.default_implementation({
            detail = docs.prettify_detail(opts.item.detail, { trim = false }),
            documentation = opts.item.documentation
                and (
                  type(opts.item.documentation) == "string"
                    and docs.prettify_detail(opts.item.documentation)
                  or {
                    kind = opts.item.documentation.kind,
                    value = docs.prettify_detail(opts.item.documentation.value),
                    -- value = opts.item.documentation.value,
                  }
                )
              or nil,
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
