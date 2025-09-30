return {
  "gelguy/wilder.nvim",
  config = function()
    local wilder = require("wilder")

    wilder.setup({
      modes = { ":", "/", "?" },
      next_key = "<Tab>",
      previous_key = "<S-Tab>",
      accept_key = "<CR>",
      reject_key = "<BS>",
    })

    -- Theme erzeugen
    local palette = wilder.popupmenu_palette_theme({
      border = "rounded",
      max_height = "75%",
      min_height = 0,
      prompt_position = "top",
      reverse = 0,
      highlights = {
        accent = wilder.make_hl(
          "WilderAccent",
          "Pmenu",
          { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }
        ),
      },
    })

    -- Renderer-Optionen (highlighter, left/right) hinzufügen
    palette.highlighter = {
      -- wilder.lua_pcre2_highlighter(), -- falls du pcre2 nutzt
      wilder.lua_fzy_highlighter(), -- fzy-lua-native
    }
    palette.left = { " ", wilder.popupmenu_devicons() }
    palette.right = { " ", wilder.popupmenu_scrollbar() }

    -- WICHTIG: kein zusätzliches { ... } um palette herum!
    wilder.set_option("renderer", wilder.popupmenu_renderer(palette))
  end,
}
