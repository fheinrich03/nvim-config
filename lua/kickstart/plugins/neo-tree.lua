return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    { "<leader>e",  ":Neotree focus<CR>",  desc = "Focus [E]xplorer",  silent = true },
    { "<leader>te", ":Neotree toggle<CR>", desc = "Toggle [E]xplorer", silent = true },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      follow_current_file = { enabled = true, leave_dirs_open = true },
      use_libuv_file_watcher = true,
      bind_to_cwd = true,
      hijack_netrw_behavior = "open_current",
      window = {
        width = 46,
        position = "left",
        mappings = {
          -- keep leader key
          ["<space>"] = "",

          -- new keymaps
          ["-"] = "navigate_up",
          ["R"] = "set_root",
          ["<tab>"] = "toggle_preview",
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
