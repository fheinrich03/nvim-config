return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  opts = {
    settings = {
      -- persist to sqlite on UI actions
      save_on_toggle = true,
      sync_on_ui_close = true,

      -- key Harpoon's storage by cwd (and optionally git branch)
      key = function()
        local cwd = vim.fn.getcwd()
        -- uncomment next 3 lines for per-branch lists:
        -- local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
        -- local branch = handle and handle:read("*l") or nil
        -- if handle then handle:close() end
        -- return branch and (cwd .. "#" .. branch) or cwd
        return cwd
      end,
    },
  },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      pickers
        .new({}, {
          prompt_title = "Harpoon",
          finder = finders.new_table({
            results = file_paths,
            entry_maker = make_entry.gen_from_file({}),
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
    -- vim.keymap.set("n", "<C-e>", function()
    --   harpoon.ui:toggle_quick_menu(harpoon:list())
    -- end)

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "[A]dd Harpoon Item" })
    vim.keymap.set("n", "<leader>lc", function()
      harpoon.ui:toggle_quick_menu(harpoon:list():clear())
    end, { desc = "[L]ist Harpoon [C]lear" })
    -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
    --
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-N>", function()
      harpoon:list():next()
    end)
  end,
}
