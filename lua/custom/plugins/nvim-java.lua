return {
  "nvim-java/nvim-java",
  config = function()
    -- Must be called before defining jdtls config
    require("java").setup()

    -- Define configuration for jdtls (empty here, extend if you need settings)
    vim.lsp.config("jdtls", {
      -- on_attach = function(client, bufnr) ... end,
      -- capabilities = require("blink.cmp").get_lsp_capabilities(),
      -- settings = { java = { ... } },
    })

    -- Enable the server
    vim.lsp.enable("jdtls")
  end,
}
