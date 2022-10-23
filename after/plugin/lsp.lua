local status, nvim_lsp = pcall(require, "lspconfig")
local status2, ts_lsp = pcall(require, "typescript")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

-- Typescript
ts_lsp.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach,
    },
})

local status2, wk = pcall(require, "which-key")

if (not status2) then return end

wk.register({
  g = {
    name = "LSP",
    k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    p = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format file" },
    d = { "<cmd>lua require'telescope.builtin'.lsp_definitions()<cr>", "Go to Definition" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    l = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
  },
}, {})

return

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}
