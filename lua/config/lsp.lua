-- ~/.config/nvim/lua/plugins/lsp.lua
require'lspconfig'.html.setup{}
require'lspconfig'.tsserver.setup{}
require("nvim-lsp-installer").setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
