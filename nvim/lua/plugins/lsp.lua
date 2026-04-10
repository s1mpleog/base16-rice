return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mason").setup({
                ui = { border = "rounded" }
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls" },
                automatic_installation = true,
            })

            local on_attach = function(_, bufnr)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end
                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gr", vim.lsp.buf.references, "Find references")
                map("gi", vim.lsp.buf.implementation, "Go to implementation")
                map("K", vim.lsp.buf.hover, "Hover docs")
                map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
                map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
                map("]d", vim.diagnostic.goto_next, "Next diagnostic")
                map("<leader>dd", vim.diagnostic.open_float, "Show diagnostic")
            end

            -- New API: vim.lsp.config instead of require('lspconfig').clangd.setup
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            -- ======================================================
            -- KEY CHANGE: use vim.lsp.config + vim.lsp.enable
            -- ======================================================
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                    "--pch-storage=memory",
                    "--log=error",
                    "-j=4",
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })

            vim.lsp.enable("clangd")

            -- lua language server
            vim.lsp.config("lua_ls", {
                on_attach    = on_attach,
                capabilities = capabilities,
                filetypes    = { "lua" },
                root_markers = { ".luarc.json", ".git" },
                settings     = {
                    Lua = {
                        runtime     = { version = "LuaJIT" }, -- Neovim uses LuaJIT
                        workspace   = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },  -- knows about vim.* APIs
                        },
                        diagnostics = { globals = { "vim" } }, -- no "undefined global vim" warnings
                        telemetry   = { enable = false },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = { prefix = "●", spacing = 4 },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded", source = "always" },
            })

            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
        end,
    },
}
