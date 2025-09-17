return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = { width = 36 },
      actions = {
        change_dir = {
          enable = true,
          global = false,
        },
      },
      filesystem_watchers = {
        enable = true,
      },
      filters = {
        git_ignored = false, -- standardmäßig an → ignorierte Dateien werden ausgeblendet
        dotfiles = false, -- dotfiles (z.B. .env, .gitignore) werden gezeigt
      },
    })

    local api = require("nvim-tree.api")
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        api.tree.open()
      end,
    })

    vim.keymap.set("n", "<leader>te", ":NvimTreeToggle<CR>", { desc = "[T]oggle File [E]xplorer" })
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus File [E]xplorer" })
  end,
}
