local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
               return client.name ~= "tsserver"
             end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

null_ls.setup {
	sources = {
	null_ls.builtins.diagnostics.eslint_d.with({
	  prefer_local = "node_modules/.bin",
	      diagnostics_format = '[eslint] #{m}\n(#{c})'
	}), -- eslint or eslint_d
	null_ls.builtins.code_actions.eslint_d.with({
	  prefer_local = "node_modules/.bin"
	}), -- eslint or eslint_d
	null_ls.builtins.formatting.prettierd.with({
	  prefer_local = "node_modules/.bin"
	}) -- prettier, eslint, eslint_d, or prettierd
	},
  on_attach = on_attach,
}
