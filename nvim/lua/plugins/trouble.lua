-- lua/plugins/trouble.lua
return {
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Project diagnostics" },
            { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer diagnostics" },
            { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols panel" },
            { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions" },
        },
        opts = {
            modes = {
                diagnostics = {
                    auto_close = true, -- close when no more errors
                    auto_preview = true, -- preview the error location
                },
            },
        },
    },
}
