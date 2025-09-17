return {
  "nvim-java/nvim-java",
  config = function()
    -- Must be called before lspconfig
    require("java").setup()

    -- Setup jdtls LSP
    require("lspconfig").jdtls.setup({})
  end,
}
