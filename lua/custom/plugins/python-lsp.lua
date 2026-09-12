return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = { "basedpyright", "ruff" },
            })

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            vim.lsp.config("basedpyright", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "basic",
                        },
                    },
                },
            })

            vim.lsp.config("ruff", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.enable({ "basedpyright", "ruff" })
        end,
    },
}
