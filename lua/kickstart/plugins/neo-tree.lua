-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    { "<leader>e", ":Neotree focus<CR>", desc = "Focus [E]xplorer", silent = true },
    { "<leader>te", ":Neotree toggle<CR>", desc = "Toggle [E]xplorer", silent = true },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      window = {
        -- Keep space available as <leader>
        mappings = {
          ["<space>"] = "<space>",
        },
      },
    },
  },
}
