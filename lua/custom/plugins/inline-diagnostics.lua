return {
  "rachartier/tiny-inline-diagnostic.nvim",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "classic",
    })

    -- Disable default virtual text so only tiny-inline shows
    vim.diagnostic.config({ virtual_text = false })
  end,
}
