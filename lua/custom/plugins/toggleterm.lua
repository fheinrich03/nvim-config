return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<CR>",                    desc = "[T]oggle terminal" },
      {
        "<leader>nt",
        "<cmd>ToggleTerm direction=horizontal<CR>",
        desc = "New terminal (same pane)",
      },
      { "<leader>nv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "[N]ew terminal [V]split" },

      -- Quick access to specific terminals (1..3) in the SAME panel/direction
      { "<leader>t1", "<cmd>1ToggleTerm<CR>",                   desc = "[T]oggle terminal 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<CR>",                   desc = "[T]oggle terminal 2" },
      { "<leader>t3", "<cmd>3ToggleTerm<CR>",                   desc = "[T]oggle terminal 3" },
      -- Cycle “term instances” by count (simple)
      {
        "<leader>gj",
        function()
          local i = (vim.g.__term_idx or 1) + 1
          if i > 3 then
            i = 1
          end
          vim.g.__term_idx = i
          vim.cmd(i .. "ToggleTerm")
        end,
        desc = "[Go] to next terminal",
      },
      {
        "<leader>gk",
        function()
          local i = (vim.g.__term_idx or 1) - 1
          if i < 1 then
            i = 3
          end
          vim.g.__term_idx = i
          vim.cmd(i .. "ToggleTerm")
        end,
        desc = "[Go] to prev terminal",
      },
    },
    opts = {
      direction = "horizontal", -- default: “same panel” feel
      -- start_in_insert = true,
      persist_size = true,
      persist_mode = true,
      shade_terminals = false,
      -- If you like a floating drop-down instead:
      -- direction = "float",
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Better navigation in terminal mode
      local wk = { buffer = nil, noremap = true, silent = true }
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function(ev)
          wk.buffer = ev.buf

          vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], wk)
          vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], wk)
          vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], wk)
          vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], wk)
        end,
      })
    end,
  },
}
