-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "<leader>oq",
  vim.diagnostic.setloclist,
  { desc = "[O]pen diagnostic [Q]uickfix list" }
)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

-- NOTE: Custom keybinds

-- Paste from Clipboard: macOS
-- Normal Mode: Cmd+v
vim.keymap.set(
  "n",
  "<D-v>",
  '"+p',
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Insert Mode: Cmd+v
vim.keymap.set(
  "i",
  "<D-v>",
  "<C-r>+",
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Command-Line Mode (z. B. : oder /)
vim.keymap.set(
  "c",
  "<D-v>",
  "<C-r>+",
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Terminal Mode
vim.keymap.set("t", "<D-v>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<C-\\><C-n>"+pi', true, false, true),
    "n",
    false
  )
end, { noremap = true, silent = true, desc = "Paste aus Clipboard im Terminal" })

-- Paste from Clipboard: Windows
-- Normal Mode: Ctrl+v
vim.keymap.set(
  "n",
  "<C-v>",
  '"+p',
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Insert Mode: Ctrl+Shift+v
vim.keymap.set(
  "i",
  "<C-v>",
  "<C-r>+",
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Command-Line Mode (: oder /): Ctrl+Shift+v
vim.keymap.set(
  "c",
  "<C-v>",
  "<C-r>+",
  { noremap = true, silent = true, desc = "Paste aus System-Clipboard" }
)

-- Terminal Mode: Ctrl+v (Windows/Linux)
vim.keymap.set("t", "<C-v>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<C-\\><C-n>"+pi', true, false, true),
    "n",
    false
  )
end, { noremap = true, silent = true, desc = "Paste aus Clipboard im Terminal" })

-- Managing Windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Open Lazygit in new Tab
vim.keymap.set("n", "<leader>nl", function()
  vim.cmd("tabnew | terminal lazygit")
end, { desc = "[N]ew tab with [L]azygit" })

-- Close Current Window
vim.keymap.set("n", "<leader>c", function()
  vim.cmd("q")
end, { desc = "[C]lose current window" })

-- Manage Buffers
vim.keymap.set("n", "<leader>qa", function()
  vim.cmd("bufdo bd!")
end, { desc = "[Q]uit [A]ll Buffers" })

-- Manage Tabs
vim.keymap.set("n", "<C-Tab>", "gt", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", "gT", { noremap = true, silent = true })

-- Saving a File
vim.keymap.set("n", "<leader>s", "<cmd>wa<CR>", { desc = "[S]ave all Files" })

-- Motions Without Updating Register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste without updating register" })
vim.keymap.set({ "n", "x" }, "<leader>x", [["_d]], { desc = "Delete without updating register" })

-- Terminal exit to normal
vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], wk)
-- vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], wk)

-- Vim Diagnostics Motions
vim.keymap.set("n", "<leader>dn", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "[D]iagnostic [N]ext" })
vim.keymap.set("n", "<leader>dp", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "[D]iagnostic [P]revious" })
vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, { desc = "[D]iagnostics [S]how" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.setqflist, { desc = "[D]iagnostics [F]ix" })

-- Vim Vertical Motions centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
