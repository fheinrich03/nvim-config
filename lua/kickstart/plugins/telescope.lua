return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
      -- ensure project.nvim is installed (or keep it as a separate spec elsewhere)
      "ahmedkhalf/project.nvim",
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "package.json", "pyproject.toml", "pom.xml", "build.gradle", "go.mod" },
        silent_chdir = true,
      })

      local actions_ok, project_actions = pcall(require, "telescope._extensions.projects.actions") -- safe if extension not present yet

      require("telescope").setup({
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}), -- <- pass the table directly
          projects = {
            on_project_selected = function(prompt_bufnr)
              if actions_ok then
                -- only change CWD; do NOT open find_files
                project_actions.change_working_directory(prompt_bufnr, false)
              end
            end,
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "projects")

      -- Builtins / keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind in [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind in [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind in [F]iles" })
      vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({ hidden = true })
      end, { desc = "[F]ind in [A]ll Files" })
      vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind in [S]elect Telescope" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind in [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind in [R]esume" })
      vim.keymap.set(
        "n",
        "<leader>f.",
        builtin.oldfiles,
        { desc = '[F]ind Recent Files ("." = repeat)' }
      )
      vim.keymap.set(
        "n",
        "<leader><leader>",
        builtin.buffers,
        { desc = "[ ] Find existing buffers" }
      )

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end, { desc = "[/] Fuzzy in current buffer" })

      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
      end, { desc = "[F]ind in [/] Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>fn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[F]ind in [N]eovim files" })
    end,
  },
}
