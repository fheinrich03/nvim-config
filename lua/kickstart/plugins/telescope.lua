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
    },
    config = function()
      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- Add paste support in Telescope prompt
      local sys = vim.loop.os_uname().sysname
      local paste_key = sys == "Darwin" and "<D-v>" or "<C-v>"

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              [paste_key] = function()
                local reg = vim.fn.getreg("+")
                local feed = vim.api.nvim_replace_termcodes(reg, true, false, true)
                vim.api.nvim_feedkeys(feed, "i", false)
              end,
            },
          },
        },
      })

      -- Builtins / keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind in [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind in [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = false, ignore = false })
      end, { desc = "[F]ind in [F]iles" })
      vim.keymap.set("n", "<leader>fa", function()
        builtin.find_files({
          hidden = true,
          ignore = true,
        })
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
