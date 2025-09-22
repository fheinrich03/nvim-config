return {
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {},
        opts = {},
      },
      "folke/lazydev.nvim",
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        -- Close the menu (and undo preview), plus hide docs/signature
        -- ["<Esc>"] = { "cancel", "hide_documentation", "hide_signature", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },

        -- 🔒 Hard-stop popups on '{'
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = false,
          -- show_on_blocked_trigger_characters = { " ", "\n", "\t", "{" },
          -- show_on_accept_on_trigger_character = false,
          -- show_on_insert_on_trigger_character = false,
          -- show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },

      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "lua" },
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
