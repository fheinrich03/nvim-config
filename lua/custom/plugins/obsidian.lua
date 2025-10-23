local vault_path =
  "~/Library/CloudStorage/GoogleDrive-heinrichfelix03@gmail.com/My Drive/Obsidian_Vault"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre "
      .. vim.fn.expand(vault_path)
      .. "/*.md",
    "BufNewFile " .. vim.fn.expand(vault_path) .. "/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "default",
        path = vault_path,
      },
    },

    -- see below for full list of options 👇
  },
}
