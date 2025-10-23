return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "~/repos/*/*",
      "~/.config/*",
      "~/Library/CloudStorage/GoogleDrive-*/My Drive/Obsidian_Vault",

      -- work PC (windows)
      "D:/app_config/*",
      vim.fn.expand("$LOCALAPPDATA/nvim"), -- windows: nvim config location
    },
    picker = {
      type = "telescope",
      preview = {
        enabled = false,
      },
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
      "<leader>op",
      ":NeovimProjectDiscover<CR>",
      vim.tbl_extend("force", opts_desc, { desc = "[O]pen [P]roject" })
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
  picker = {
    type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"

    preview = {
      enabled = true, -- show directory structure in Telescope preview
      git_status = true, -- show branch name, an ahead/behind counter, and the git status of each file/folder
      git_fetch = false, -- fetch from remote, used to display the number of commits ahead/behind, requires git authorization
      show_hidden = true, -- show hidden files/folders
    },
    opts = {
      -- picker-specific options
    },
  },
}
