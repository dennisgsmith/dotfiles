local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    'folke/neodev.nvim',
    "hrsh7th/cmp-nvim-lsp",
    'williamboman/mason.nvim',
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {},
  config = function(_, _)
    local utils = require("utils")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    local format_is_enabled = true
    vim.api.nvim_create_user_command('ToggleFormatting', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        if client.name == 'tsserver' then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })

    vim.diagnostic.config({
      virtual_text = false,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = false,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

    local on_attach = function(_, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('gT', vim.lsp.buf.type_definition, '[G]oto [T]ype')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    ---- sign column
    local signs = require("utils").lsp_signs

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    mason_lspconfig.setup({
      ensure_installed = utils.lsp_servers,
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["gopls"] = function()
        lspconfig.gopls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
            },
            analyses = { unusedparams = true },
          },
        })
      end,
      ["pyright"] = function()
        lspconfig.pyright.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["jsonls"] = function()
        lspconfig.jsonls.setup({
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
              end
            }
          },
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["clangd"] = function()
        local capabilities_cpp = capabilities
        capabilities_cpp.offsetEncoding = { "uts-16" }
        lspconfig.clangd.setup({
          on_attach = on_attach,
          capabilities = capabilities_cpp,
        })
      end,
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"
              },
              format = {
                enable = true,
              },
              telemetry = {
                enable = false,
              },
            }
          },
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}

local mason_config = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    pip = {
      upgrade_pip = true,
    },
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local utils = require("utils")
    local mr = require("mason-registry")
    local packages = utils.mason_packages
    local function ensure_installed()
      for _, package in ipairs(packages) do
        local p = mr.get_package(package)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}

return { nvim_lspconfig, mason_config }
