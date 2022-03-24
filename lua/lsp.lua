local lspconfig = require("lspconfig")
local servers = {
    "bashls",
	"ccls",
	"gopls",
	"pyright",
	"rust_analyzer",
	"tailwindcss",
	"texlab",
	-- "tsserver",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	})
end

require("lspconfig").tsserver.setup({
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format.with({
			extra_args = { "--style", "{IndentWidth: 4}" },
		}),
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
	},
})
