return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local lspconfig = require("lspconfig")

            -- Add your servers here
            local servers = { "pyright", "clangd" }

            -- Merge with LazyVim defaults
            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = opts.capabilities,
                    on_attach = function(client, bufnr)
                        -- Preserve existing LazyVim keymaps
                        if opts.on_attach then
                            opts.on_attach(client, bufnr)
                        end

                        -- Add rename keybinding
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP Rename" })
                    end,
                })
            end
        end,
    },
}
