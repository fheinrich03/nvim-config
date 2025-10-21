return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- sofort laden (nicht erst bei einem Event)
  priority = 1000, -- früh laden, damit es vor anderen Themes greift
  enabled = true,
  config = function()
    require("transparent").setup({
      groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
      },
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "WinSeparator",
        "Pmenu",
        "PmenuSbar",
        "PmenuThumb",
        "TelescopeNormal",
        "TelescopeBorder",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NvimTreeNormal",
        "WhichKeyFloat",
      },
      exclude_groups = {}, -- falls du Gruppen ausnehmen willst
      on_clear = function() end,
    })

    -- Direkt Transparenz aktivieren
    require("transparent").clear_prefix("lualine") -- optional, falls du lualine nutzt
  end,
}
