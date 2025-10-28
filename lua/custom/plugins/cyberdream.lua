return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      saturation = 0.9,
      transparent = true,
      colors = {
        dark = {
          fg = "#eeeeee"
        }
      }
    })
    -- enable colorscheme
    vim.cmd("colorscheme cyberdream")
  end,
}
