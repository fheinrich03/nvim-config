return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- 👈 add this
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      -- indent = { enable = true, disable = { 'ruby' } },

      -- 👇 Add textobjects config here
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            ["af"] = "@function.outer", -- Select around function
            ["if"] = "@function.inner", -- Select inside function
            ["ac"] = "@class.outer", -- Around class
            ["ic"] = "@class.inner", -- Inside class
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
