return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local lspconfig = require("lspconfig")

            local servers = { "pyright", "clangd" }

            for _, server in ipairs(servers) do
                local server_opts = {
                    capabilities = opts.capabilities,
                    on_attach = function(client, bufnr)
                        -- Preserve LazyVim defaults
                        if opts.on_attach then
                            opts.on_attach(client, bufnr)
                        end

                        -- Disable autoformat only for clangd
                        if client.name == "clangd" then
                            vim.g.autoformat = false
                        end

                        -- Your custom keymap
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP Rename" })
                    end,
                }

                if server == "clangd" then
                    server_opts.cmd = {
                        "clangd",
                        "--fallback-style=none",
                    }
                end

                lspconfig[server].setup(server_opts)
            end
        end,
    },
}
