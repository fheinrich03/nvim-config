return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "~/repos/*/*",
      "~/.config/*",
    },
    picker = {
      type = "telescope",
    },
  },
  init = function()
    vim.opt.sessionoptions:append("globals")
  end,
  config = function(_, opts)
    require("neovim-project").setup(opts)

    -- keymaps for NeovimProject commands
    local map = vim.keymap.set
    local opts_desc = { noremap = true, silent = true }

    map(
      "n",
      "<leader>od",
      ":NeovimProjectDiscover<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen project [D]iscover" })
    )
    map(
      "n",
      "<leader>oh",
      ":NeovimProjectHistory<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen project [H]istory" })
    )
    map(
      "n",
      "<leader>or",
      ":NeovimProjectLoadRecent<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen project [R]ecent" })
    )
    map(
      "n",
      "<leader>ol",
      ":NeovimProjectLoadHist<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen project [L]oad Hist" })
    )
    map(
      "n",
      "<leader>op",
      ":NeovimProjectLoad<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen project [P]ick" })
    )
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    { "ibhagwan/fzf-lua" },
    { "folke/snacks.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
