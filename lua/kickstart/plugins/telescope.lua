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

      local ignore_patterns = {
        "node_modules",
        ".next",
        "%.git/",
        "target/",
        "%.class",
        "%.o",
        "%.pyc",
        "__pycache__/",
        "venv/",
        "%.png",
      }
      -- Funktion, um ein ripgrep-Kommando aus den Mustern zu bauen
      local function build_rg_command()
        local cmd = { "rg", "--files", "--hidden", "-uu" } -- -uu = ignoriere .gitignore komplett
        for _, pattern in ipairs(ignore_patterns) do
          local clean = pattern:gsub("%%", "") -- entferne Lua-Escape-Zeichen (%)
          table.insert(cmd, "--glob")
          table.insert(cmd, "!" .. clean) -- eigene excludes
        end
        return cmd
      end

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
          file_ignore_patterns = ignore_patterns,
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            ignore_current_buffer = false,
            sort_mru = true,
          },
        },
      })

      -- Builtins / keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind in [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind in [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({
          find_command = build_rg_command(),
        })
      end, { desc = "[F]ind in [F]iles" })
      vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[F]ind in [T]elescope" })
      vim.keymap.set(
        "n",
        "<leader>fs",
        builtin.lsp_document_symbols,
        { desc = "[F]ind in Document [S]ymbols" }
      )
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind in [D]iagnostics" })
      vim.keymap.set(
        "n",
        "<leader><leader>",
        builtin.oldfiles,
        { desc = "[ ] Find in Recent Files" }
      )
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind in existing [B]uffers" })

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
