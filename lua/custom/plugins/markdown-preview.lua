return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreview<CR>", {
      desc = "[P]review Markdown File",
    })
    vim.keymap.set("n", "<leader>tp", "<cmd>MarkdownPreviewStop<CR>", {
      desc = "[T]oggle Markdown Preview",
    })
  end,
}
