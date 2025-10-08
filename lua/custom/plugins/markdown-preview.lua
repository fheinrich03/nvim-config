return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    -- Go into app folder
    local install_cmd = [[
      cd app &&
      (yarn install || npm install)
    ]]

    -- Run command (cross-platform)
    if vim.fn.has("win32") == 1 then
      -- Windows uses 'cmd /c'
      vim.fn.system({ "cmd", "/c", install_cmd })
    else
      -- macOS/Linux
      vim.fn.system({ "sh", "-c", install_cmd })
    end
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<CR>", {
      desc = "[M]arkdown Preview File",
    })
  end,
}
