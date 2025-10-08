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

-- [[Managing Windows]]
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>q", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local bt = vim.bo[bufnr].buftype

  if bt == "" then
    -- "Normaler" Dateibuffer: erst mit Confirm den Buffer löschen (fragt bei Änderungen),
    -- danach das Fenster schließen.
    vim.cmd("confirm bdelete")
    -- Fenster schließen (falls noch mehrere offen sind)
    pcall(vim.cmd, "close")
  else
    -- Nicht-Dateibuffer (z.B. terminal, help, nofile ...): nur Fenster zu
    pcall(vim.cmd, "close")
  end
end, { desc = "[Q]uit Window + (File) Buffer w/ confirm" })

-- [[Manage Tabs]]
vim.keymap.set("n", "<C-Tab>", "gt", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", "gT", { noremap = true, silent = true })

-- [[Saving a File]]
vim.keymap.set("n", "<leader>s", "<cmd>wa<CR>", { desc = "[S]ave all Files" })

-- [[Motions Without Updating Register]]
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste without updating register" })
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]], { desc = "[D]elete without updating register" })
