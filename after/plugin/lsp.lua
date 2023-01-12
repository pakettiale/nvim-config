local status, nvim_lsp = pcall(require, "lspconfig")
local ts_status, ts_lsp = pcall(require, "typescript")

-- Typescript
if (ts_status) then
  local protocol = require('vim.lsp.protocol')

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end

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
end

local ht_status, ht = pcall(require, "haskell-tools")

if (ht_status) then 
  local def_opts = { noremap = true, silent = true, }
  ht.setup {
    hls = {
      cmd = { "haskell-language-server-wrapper", "--lsp", },
      on_attach = function(client, bufnr)
        local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
        vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
      end,
    },
  }
  vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
  vim.keymap.set('n', '<leader>rf', function ()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
  end, def_opts)
  vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)
end

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
