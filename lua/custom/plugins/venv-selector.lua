return {
  "linux-cultist/venv-selector.nvim",
  opts = { name = ".venv" }, -- bevorzugt .venv
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
  },
}
