-- Setup language servers.

local ts_settings = {
  typescript = {
    inlayHints = {
      -- You can set this to 'all' or 'literals' to enable more hints
      includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHints = false,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
}
-- check if server exists before setting the path
local filename = "/data/data/com.termux/files/usr/bin/typescript-language-server"
if vim.uv.fs_stat(filename) then
  vim.lsp.config("ts_ls", {
    cmd = { "node", filename, "--stdio" },
    settings = ts_settings,
  })
else
  vim.lsp.config("ts_ls", {
    settings = ts_settings,
  })
end

vim.lsp.config("tsgo", {
  settings = ts_settings,
})

vim.lsp.config("jsonls", {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/vscode-json-language-server",
    "--stdio",
  },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas({
        select = {
          "Renovate",
          "GitHub Workflow Template Properties",
        },
      }),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("ty", {
  settings = {
    ty = {
      experimental = {
        rename = true,
      },
      inlayHints = {
        variableTypes = true,
      },
    },
  },
})

vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      dialect = "Australian",
    },
  },
})

vim.lsp.config("jdtls", {
  cmd_env = {
    JDTLS_JVM_ARGS = "-javaagent:"
      .. vim.fn.expand("$HOME/.m2/repository/org/projectlombok/lombok/1.18.40/lombok-1.18.40.jar"),
  },
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",
          exclusions = { "this" },
        },
      },
    },
  },
})

vim.lsp.config("gopls",
  settings = {
    gopls = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    },
  },
})

vim.lsp.enable({
  "ty",
  "ts_ls",
  "ruff",
  "tombi",
  "harper_ls",
  "emmylua_ls",
  "jsonls",
  "yamlls",
  "gh_actions_ls",
  "fish_lsp",
  "graphql",
  "jdtls",
  "gopls",
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local bufnr = ev.buf
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client.name ~= "lua_ls" and client:supports_method("textDocument/documentSymbol") then
      require("nvim-navic").attach(client, bufnr)
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufno = bufnr })
    end

    function do_format(format_client)
      if format_client.name == "ts_ls" then
        return false
      else
        return true
      end
    end

    if
      not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            id = client.id,
            timeout_ms = 1000,
            filter = do_format,
          })
        end,
      })
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true, filter = do_format })
    end, opts)
  end,
})
