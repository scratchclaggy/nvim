local lspconfig = require("lspconfig")
local servers = require("servers")

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities())
    }
end

require("trouble").setup {}

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.prettier
    }
})

