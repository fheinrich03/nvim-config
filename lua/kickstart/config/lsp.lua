local M = {}

function M.setup()
  ---------------------------------------------------------------------------
  -- Diagnostics UI
  ---------------------------------------------------------------------------
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    } or {},
    virtual_text = {
      source = "if_many",
      spacing = 2,
      format = function(d)
        return d.message
      end,
    },
  })

  ---------------------------------------------------------------------------
  -- LspAttach (keymaps, highlights, inlay hints)
  ---------------------------------------------------------------------------
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
      map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
      map(
        "gW",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "Open Workspace Symbols"
      )
      map("K", vim.lsp.buf.hover, "Hover")
      map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype")

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local function supports(method, bufnr)
        if vim.fn.has("nvim-0.11") == 1 then
          return client and client:supports_method(method, bufnr)
        else
          return client
            and client.supports_method
            and client.supports_method(method, { bufnr = bufnr })
        end
      end

      if
        client and supports(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
      then
        local hl = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = hl,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = hl,
          callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(ev)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = ev.buf })
          end,
        })
      end

      if client and supports(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })

  ---------------------------------------------------------------------------
  -- Capabilities (blink.cmp)
  ---------------------------------------------------------------------------
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  ---------------------------------------------------------------------------
  -- Servers
  ---------------------------------------------------------------------------
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          -- diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
    ts_ls = {},
    eslint = {},
    jsonls = {},
    jdtls = {},
    gopls = {},
    pyright = {},
    html = {},
    cssls = {},
    tailwindcss = {},
    marksman = {},
    ltex = {},
    angularls = {},
    emmet_ls = {},
    kotlin_language_server = {},
  }

  ---------------------------------------------------------------------------
  -- Define default + per-server configs using Neovim’s native API
  -- (Neovim 0.11+: vim.lsp.config / vim.lsp.enable) :contentReference[oaicite:1]{index=1}
  ---------------------------------------------------------------------------
  vim.lsp.config("*", {
    capabilities = capabilities,
    -- on_attach can live inside LspAttach; keep empty here
  })

  for name, conf in pairs(servers) do
    conf.capabilities = vim.tbl_deep_extend("force", {}, capabilities, conf.capabilities or {})
    vim.lsp.config(name, conf)
  end

  ---------------------------------------------------------------------------
  -- Mason installers
  ---------------------------------------------------------------------------
  local ensure = vim.tbl_keys(servers or {})
  vim.list_extend(ensure, { "stylua", "prettier" })
  require("mason-tool-installer").setup({ ensure_installed = ensure })

  -- mason-lspconfig v2+: handlers/setup_handlers removed; it can auto-enable
  -- installed servers via native API. Defaults to enabled (“automatic_enable”).
  -- Just having it loaded (opts = {}) is enough with lazy.nvim. :contentReference[oaicite:2]{index=2}
  -- If you prefer manual enabling:
  -- for name, _ in pairs(servers) do vim.lsp.enable(name) end
end

return M
