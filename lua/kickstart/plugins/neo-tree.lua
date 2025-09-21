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
    { "<leader>e", ":Neotree focus<CR>", desc = "Focus [E]xplorer", silent = true },
    { "<leader>te", ":Neotree toggle<CR>", desc = "Toggle [E]xplorer", silent = true },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      follow_current_file = { enabled = true, leave_dirs_open = true },
      use_libuv_file_watcher = true,
      bind_to_cwd = true,
      window = {
        width = 46,
        mappings = {
          -- keep leader key
          ["<space>"] = "<space>",

          ["<tab>"] = "toggle_preview",
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },

  init = function()
    local function open_neotree()
      if vim.bo.filetype ~= "neo-tree" then
        vim.schedule(function()
          require("neo-tree.command").execute({
            action = "show",
            source = "filesystem",
            position = "left",
            reveal = true,
          })
        end)
      end
    end

    -- Open on plain `nvim` (no file args, no stdin)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc(-1) == 0 and vim.fn.line2byte("$") == -1 then
          vim.defer_fn(open_neotree, 50)
        end
      end,
      once = true,
    })

    -- Open after session restore (neovim-project)
    vim.api.nvim_create_autocmd("User", {
      pattern = "SessionLoadPost",
      callback = function()
        vim.defer_fn(open_neotree, 50)
      end,
      once = true,
    })
  end,
}
